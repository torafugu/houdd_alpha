# Updater class of Mob.
# noinspection ALL
class MobUpdater

  def self.age_all_mobs(days)
    Mob.all.each do |mob|
      mob.age += days

      # Check natural death.
      longevity_mod = 0
      if mob.specie.family.asexual_flg
        longevity_mod = mob.dnas.first.gene.longevity_mod
      else
        gene_a = mob.dnas.first.gene
        gene_b = mob.dnas.last.gene
        if gene_a.dominance_flg and not gene_b.dominance_flg
          longevity_mod = gene_a.longevity_mod
        elsif not gene_a.dominance_flg and gene_b.dominance_flg
          longevity_mod = gene_b.longevity_mod
        else
          longevity_mod = gene_a.longevity_mod + gene_b.longevity_mod
        end
      end

      longevity = Mob.status_from_gene(mob.specie.longevity, longevity_mod)
      # p "longevity:" + longevity.to_s
      if longevity < mob.age
        mob.hp = 0
        mob.natural_death_flg = true
        # p "Died a natural death"
      end
      # p mob.age
      mob.save
    end
  end

end