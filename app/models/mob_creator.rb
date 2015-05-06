# Factory class of Mob.
# noinspection ALL
class MobCreator

  # Create seed mobs.
  # @param [Integer] specie_id Specie.id
  # @param [Integer] num Number of mobs to be created.
  def self.seed_mobs(specie_id, num)

    return false if num < 1

    specie = Specie.find(specie_id)
    return false if specie.blank?

    num.times do

      # Create mob.
      mob = Mob.new
      mob.specie_id = specie.id

      # Create genes and dnas.
      dna_quantity = Params::MOB_DNA_QUANTITY
      dna_quantity = 1 if mob.specie.family.asexual_flg

      dna_quantity.times do
        gene = Gene.new
        gene.specie_id = specie.id
        gene.dominance_flg = Tools.random_boolean
        gene = shake_gene(gene,  mob.specie.mutation_rate)
        gene.save
        p gene

        dna = Dna.new
        dna.mob_id = mob.id
        dna.gene_id = gene.id
        dna.save

        mob.dnas << dna
      end

      # Create status modifying gene.
      mod_gene = Gene.new
      if mob.specie.family.asexual_flg
        mod_gene = mob.dnas.first.gene
      elsif mob.dnas.first.gene.dominance_flg and not mob.dnas.last.gene.dominance_flg
        mod_gene = mob.dnas.first.gene
      elsif not mob.dnas.first.gene.dominance_flg and mob.dnas.last.gene.dominance_flg
        mod_gene = mob.dnas.last.gene
      else
        mod_gene = mob.dnas.first.gene + mob.dnas.last.gene
      end

      # Create starting status.
      mob.specie_id = specie.id
      mob.father_id = nil
      mob.mother_id = nil
      mob.houdd_user_id = nil
      mob.squad_id = nil
      mob = new_mob(mob, mod_gene)
    end
  end

  # Assign new (first genartion) mobs to user.
  # The first genartion mob is a mob which is created from seed mobs.
  # @param [Integer] num Number of mobs to be created.
  # @param [Integer] user_id HouddUser.id
  # @param [Integer] specie_id Specie.id
  def self.assign_new_mobs(num, user_id = nil, specie_id = nil)

    # Validation
    return false if num < 1

    if specie_id.blank?
      specie_id = Specie.all.sample.id
    end

    num.times do

      mob = Mob.new
      mob.specie_id = specie_id
      mob.houdd_user_id = user_id

      if mob.specie.family.asexual_flg
        mob.mother_id = Mob.find_all_by_specie_id_and_generation(specie_id, nil).sample.id
      else
        mob.father_id = Mob.find_all_by_specie_id_and_generation_and_gender_sym(specie_id, nil, Params::GENDER_MALE.to_s).sample.id
        mob.mother_id = Mob.find_all_by_specie_id_and_generation_and_gender_sym(specie_id, nil, Params::GENDER_FEMALE.to_s).sample.id
      end

      # Create status modifying gene.
      mod_gene = Gene.new
      gene_a = nil
      gene_b = nil
      if mob.specie.family.asexual_flg
        mod_gene = mob.mother.dnas.first.gene
      else
        gene_a = mob.mother.dnas.sample.gene
        gene_b = mob.father.dnas.sample.gene

        if gene_a.dominance_flg and not gene_b.dominance_flg
          mod_gene = gene_a
        elsif not gene_a.dominance_flg and gene_b.dominance_flg
          mod_gene = gene_b
        else
          mod_gene = gene_a + gene_b
        end
      end

      # Effect of miss print
      mod_gene = shake_gene(mod_gene, mob.specie.mutation_rate)

      # Create starting status.
      mob.squad_id = nil
      mob.generation = 1
      mob = new_mob(mob, mod_gene)

      # Set DNA.
      if mob.specie.family.asexual_flg
        dna = Dna.new
        dna.mob_id = mob.id
        dna.gene_id = mod_gene.id
        dna.save
        mob.dnas << dna
      else
        dna_a = Dna.new
        dna_a.mob_id = mob.id
        dna_a.gene_id = gene_a.id
        dna_a.save
        mob.dnas << dna_a

        dna_b = Dna.new
        dna_b.mob_id = mob.id
        dna_b.gene_id = gene_b.id
        dna_b.save
        mob.dnas << dna_b
      end
    end
  end

  # Check the specie whether it is able to mate or not.
  # @note "able to mate" means both father mob and mother mob are existing.
  # @param [Integer] user_id HouddUser.id
  # @param [Integer] specie_id Specie.id
  # @return [Boolean] the size of the file
  def self.specie_able_to_mate?(user_id, specie_id)

    return false if user_id.blank? or specie_id.blank?

    father = Mob.find_all_by_houdd_user_id_and_specie_id_and_gender_sym(user_id, specie_id, Params::GENDER_MALE.to_s).sample
    mother = Mob.find_all_by_houdd_user_id_and_specie_id_and_gender_sym(user_id, specie_id, Params::GENDER_FEMALE.to_s).sample

    return false if father.blank? or mother.blank?
    return true
  end

  # Create new mob by mating.
  # @note This method calls mate_mob function after selected mating pair in this function.
  # @param [Integer] num Number of mobs to be created.
  # @param [Integer] user_id HouddUser.id
  # @param [Integer] specie_id Specie.id
  def self.random_mate_mob(num, user_id = nil, specie_id = nil)

    # Validation
    return false if num < 1

    if user_id.blank?
      user_id = HouddUser.all.sample.id
    end

    user = HouddUser.find(user_id)

    if specie_id.blank?
      specie_id = user.sexual_species.sample.id
    end

    return false if specie_id.blank?

    num.times do
      father = Mob.find_all_by_houdd_user_id_and_specie_id_and_gender_sym(user_id, specie_id, Params::GENDER_MALE.to_s).sample
      mother = Mob.find_all_by_houdd_user_id_and_specie_id_and_gender_sym(user_id, specie_id, Params::GENDER_FEMALE.to_s).sample

      if father.blank? or mother.blank?
        return false
      else
        mate_mob(father.id, mother.id)
      end
    end
  end

  # Create new mob by splitting.
  # @note This method calls split_mob function after selected mob in this function.
  # @param [Integer] num Number of mobs to be created.
  # @param [Integer] user_id HouddUser.id
  # @param [Integer] specie_id Specie.id
  def self.random_split_mob(num, user_id = nil, specie_id = nil)
    
    # Validation
    return false if num < 1

    if user_id.blank?
      user_id = HouddUser.all.sample.id
    end

    user = HouddUser.find(user_id)

    if specie_id.blank?
      specie_id = user.asexual_species.sample.id
    end

    return false if specie_id.blank?

    num.times do
      mother = Mob.find_all_by_houdd_user_id_and_specie_id(user_id, specie_id).sample

      if mother.blank?
        return false
      else
        split_mob(mother.id)
      end
    end
  end

  # Create new mob by mating.
  # @note This method is only for mobs of sexual reproduction.
  # @param [Integer] father_id Mob.id
  # @param [Integer] mother_id Mob.id
  def self.mate_mob(father_id, mother_id)
    mob = Mob.new
    mob.father_id = father_id
    mob.mother_id = mother_id
    mob.specie_id = mob.mother.specie.id
    mob.houdd_user_id = mob.mother.houdd_user_id
    mob.generation = mob.mother.generation + 1

    gene_a = mob.mother.dnas.sample.gene
    gene_b = mob.father.dnas.sample.gene

    if gene_a.dominance_flg and not gene_b.dominance_flg
      mod_gene = gene_a
    elsif not gene_a.dominance_flg and gene_b.dominance_flg
      mod_gene = gene_b
    else
      mod_gene = gene_a + gene_b
    end

    # Effect of miss print
    mod_gene = shake_gene(mod_gene, mob.specie.mutation_rate)

    # Create starting status.
    mob.squad_id = nil
    mob = new_mob(mob, mod_gene)

    # Set DNA.
    dna_a = Dna.new
    dna_a.mob_id = mob.id
    dna_a.gene_id = gene_a.id
    dna_a.save
    mob.dnas << dna_a

    dna_b = Dna.new
    dna_b.mob_id = mob.id
    dna_b.gene_id = gene_b.id
    dna_b.save
    mob.dnas << dna_b
  end

  # Create new mob by splitting.
  # @note This method is only for mobs of asexual reproduction.
  # @param [Integer] mother_id Mob.id
  def self.split_mob(mother_id)
    mob = Mob.new
    mob.father_id = nil
    mob.mother_id = mother_id
    mob.specie_id = mob.mother.specie.id
    mob.houdd_user_id = mob.mother.houdd_user_id
    mob.generation = mob.mother.generation + 1

    mod_gene = mob.mother.dnas.first.gene

    # Effect of miss print
    mod_gene = shake_gene(mod_gene, mob.specie.mutation_rate)

    # Create starting status.
    mob.squad_id = nil
    mob = new_mob(mob, mod_gene)

    # Set DNA.
    dna = Dna.new
    dna.mob_id = mob.id
    dna.gene_id = mod_gene.id
    dna.save
    mob.dnas << dna
  end

  private

  def self.random_gender_sym(asexual_flg)
    if asexual_flg
      return Params::GENDER_ASEXUAL.to_s
    else
      if Tools.random_boolean
        return Params::GENDER_FEMALE.to_s
      else
        return Params::GENDER_MALE.to_s
      end
    end
  end

  def self.shake_gene(gene, variance)
    gene.prolificacy_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.longevity_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.growth_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.food_cost_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.str_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.dex_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.con_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.int_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.wis_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.cha_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.phys_def_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.skill_def_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.ele_fw_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    gene.ele_ld_mod = Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(4)
    return gene
  end

  def self.new_mob(mob, mod_gene)

    # Create starting status.
    mob.name = mob.specie.name + ((0..9).to_a).shuffle[0..9].join
    mob.gender_sym = random_gender_sym(mob.specie.family.asexual_flg)
    mob.age = (Mob.status_from_gene(mob.specie.longevity, mod_gene.longevity_mod) * Params::MOB_ADULT_AGE_RATE).round
    mob.str = Mob.status_from_gene(mob.specie.str, mod_gene.str_mod).round
    mob.dex = Mob.status_from_gene(mob.specie.dex, mod_gene.dex_mod).round
    mob.con = Mob.status_from_gene(mob.specie.con, mod_gene.con_mod).round
    mob.int = Mob.status_from_gene(mob.specie.int, mod_gene.int_mod).round
    mob.wis = Mob.status_from_gene(mob.specie.wis, mod_gene.wis_mod).round
    mob.cha = Mob.status_from_gene(mob.specie.cha, mod_gene.cha_mod).round
    mob.phys_def = Mob.status_from_gene(mob.specie.phys_def, mod_gene.phys_def_mod).round
    mob.skill_def = Mob.status_from_gene(mob.specie.skill_def, mod_gene.skill_def_mod).round
    mob.ele_fw = Mob.status_from_gene(mob.specie.ele_fw, mod_gene.ele_fw_mod).round
    mob.ele_ld = Mob.status_from_gene(mob.specie.ele_ld, mod_gene.ele_ld_mod).round

    # set job
    job_roll = rand(100) + 1
    prev_frequency_rate = 1
    mob.specie.specie_job_invs.each do |job_inv|
      if job_roll.between?(prev_frequency_rate, prev_frequency_rate + job_inv.frequency_rate - 1)
        mob.job_id = job_inv.job_id
        break
      end
      prev_frequency_rate += job_inv.frequency_rate
    end

    # apply job status modification.
    mob.str = mob.str * (1 + mob.job.str_mod).round
    mob.dex = mob.dex * (1 + mob.job.dex_mod).round
    mob.con = mob.con * (1 + mob.job.con_mod).round
    mob.int = mob.int * (1 + mob.job.int_mod).round
    mob.wis = mob.wis * (1 + mob.job.wis_mod).round
    mob.cha = mob.cha * (1 + mob.job.cha_mod).round
    mob.hp = mob.con
    mob.sp = mob.int
    mob.phys_def = mob.phys_def * (1 + mob.job.phys_def_mod).round
    mob.skill_def = mob.skill_def * (1 + mob.job.skill_def_mod).round
    mob.ele_fw = mob.ele_fw * (1 + mob.job.ele_fw_mod).round
    mob.ele_ld = mob.ele_ld * (1 + mob.job.ele_ld_mod).round
    mob.save

    return mob
  end
end