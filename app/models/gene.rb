# This class describes a gene of Mob.
class Gene < ActiveRecord::Base
  belongs_to :specie

  # Add another Gene attribute value.
  # @param [Gene] other other Gene instance.
  # @return [Gene] attribute added Gene instance.
  def +(other)
    return nil if specie_id != other.specie_id

    new_gene = Marshal.load(Marshal.dump(self))
    new_gene.specie_id = specie_id
    if dominance_flg != other.dominance_flg
      new_gene.dominance_flg = Tools.random_boolean
    else
      new_gene.dominance_flg = dominance_flg
    end
    new_gene.prolificacy_mod = mate_mod_value(prolificacy_mod, other.prolificacy_mod)
    new_gene.longevity_mod = mate_mod_value(longevity_mod, other.longevity_mod)
    new_gene.growth_mod = mate_mod_value(growth_mod, other.growth_mod)
    new_gene.food_cost_mod = mate_mod_value(food_cost_mod, other.food_cost_mod)
    new_gene.str_mod = mate_mod_value(str_mod, other.str_mod)
    new_gene.dex_mod = mate_mod_value(dex_mod, other.dex_mod)
    new_gene.con_mod = mate_mod_value(con_mod, other.con_mod)
    new_gene.int_mod = mate_mod_value(int_mod, other.int_mod)
    new_gene.wis_mod = mate_mod_value(wis_mod, other.wis_mod)
    new_gene.cha_mod = mate_mod_value(cha_mod, other.cha_mod)
    new_gene.phys_def_mod = mate_mod_value(phys_def_mod, other.phys_def_mod)
    new_gene.skill_def_mod = mate_mod_value(skill_def_mod, other.skill_def_mod)
    new_gene.ele_fw_mod = mate_mod_value(ele_fw_mod, other.ele_fw_mod)
    new_gene.ele_ld_mod = mate_mod_value(ele_ld_mod, other.ele_ld_mod)
    return new_gene
  end

  private

  def mate_mod_value(mod1, mod2)
    mod_mix_rate = Tools.gaussian_rand(0.5, Params::GENE_MIX_VARIANCE).round(2)
    return (mod1 * mod_mix_rate + mod2 * (1 - mod_mix_rate)).round(4)
  end
end
