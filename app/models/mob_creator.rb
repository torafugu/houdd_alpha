class MobCreator

  # Cretae seed mobs.
  def self.seed_mobs(specie_id, num)

    return false if num < 1

    specie = Specie.find(specie_id)
    return false if specie.blank?

    num.times do

      # Create mob.
      mob = Mob.new
      mob.specie_id = specie.id

      # Create genes and dnas.
      Params::MOB_DNA_QUANTITY.times do
        gene = Gene.new
        gene.specie_id = specie.id
        gene.dominance_flg = Tools.random_boolean
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
        gene.save
        p gene

        dna = Dna.new
        dna.mob_id = mob.id
        dna.gene_id = gene.id
        dna.save

        mob.dnas << dna
      end

      #p mob.dnas

      # Create status modifying gene.
      mod_gene = Gene.new
      if mob.dnas.first.gene.dominance_flg and not mob.dnas.last.gene.dominance_flg
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
      mob.name = specie.name + ((0..9).to_a).shuffle[0..9].join
      mob.gender_sym = random_gender_sym(specie.family.asexual_flg)
      mob.age = status_from_gene(specie.longevity, mod_gene.longevity_mod) * Params::MOB_ADULT_AGE_RATE
      mob.str = status_from_gene(specie.str, mod_gene.str_mod)
      mob.dex = status_from_gene(specie.dex, mod_gene.dex_mod)
      mob.con = status_from_gene(specie.con, mod_gene.con_mod)
      mob.int = status_from_gene(specie.int, mod_gene.int_mod)
      mob.wis = status_from_gene(specie.wis, mod_gene.wis_mod)
      mob.cha = status_from_gene(specie.cha, mod_gene.cha_mod)
      mob.phys_def = status_from_gene(specie.phys_def, mod_gene.phys_def_mod)
      mob.skill_def = status_from_gene(specie.skill_def, mod_gene.skill_def_mod)
      mob.ele_fw = status_from_gene(specie.ele_fw, mod_gene.ele_fw_mod)
      mob.ele_ld = status_from_gene(specie.ele_ld, mod_gene.ele_ld_mod)

      # set job
      job_roll = rand(100) + 1
      prev_frequency_rate = 1
      specie.specie_job_invs.each do |job_inv|
        if job_roll.between?(prev_frequency_rate, prev_frequency_rate + job_inv.frequency_rate - 1)
          mob.job_id = job_inv.job_id
          break
        end
        prev_frequency_rate += job_inv.frequency_rate
      end

      # apply job status modification.
      mob.str = mob.str * (1 + mob.job.str_mod)
      mob.dex = mob.dex * (1 + mob.job.dex_mod)
      mob.con = mob.con * (1 + mob.job.con_mod)
      mob.int = mob.int * (1 + mob.job.int_mod)
      mob.wis = mob.wis * (1 + mob.job.wis_mod)
      mob.cha = mob.cha * (1 + mob.job.cha_mod)
      mob.hp = mob.con
      mob.sp = mob.int
      mob.phys_def = mob.phys_def * (1 + mob.job.phys_def_mod)
      mob.skill_def = mob.skill_def * (1 + mob.job.skill_def_mod)
      mob.ele_fw = mob.ele_fw * (1 + mob.job.ele_fw_mod)
      mob.ele_ld = mob.ele_ld * (1 + mob.job.ele_ld_mod)
      mob.save
    end
  end

  private

  def self.status_from_gene(base, mod)
    return base * (1 + mod * Tools.gaussian_rand(0, Params::GENE_SEED_VARIANCE).round(2))
  end

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
end