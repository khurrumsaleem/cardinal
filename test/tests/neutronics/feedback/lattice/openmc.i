[Mesh]
  type = FileMesh
  file = ../../meshes/pincell.e
[]

[AuxVariables]
  [cell_id]
    family = MONOMIAL
    order = CONSTANT
  []
  [cell_instance]
    family = MONOMIAL
    order = CONSTANT
  []
  [cell_temperature]
    family = MONOMIAL
    order = CONSTANT
  []
  [material_id]
    family = MONOMIAL
    order = CONSTANT
  []
  [cell_density]
    family = MONOMIAL
    order = CONSTANT
  []
[]

[AuxKernels]
  [material_id]
    type = CellMaterialIDAux
    variable = material_id
  []
  [cell_id]
    type = CellIDAux
    variable = cell_id
  []
  [cell_instance]
    type = CellInstanceAux
    variable = cell_instance
  []
  [cell_temperature]
    type = CellTemperatureAux
    variable = cell_temperature
    execute_on = 'timestep_end'
  []
  [cell_density]
    type = CellDensityAux
    variable = cell_density
    execute_on = 'timestep_end'
  []
[]

[Problem]
  type = OpenMCCellAverageProblem
  verbose = true
  power = 500.0

  temperature_blocks = '1 2 3'
  density_blocks = '2'

  cell_level = 1

  tally_type = cell
  tally_blocks = '1'
  tally_name = heat_source
[]

[Executioner]
  type = Transient
[]

[Postprocessors]
  [heat_source]
    type = ElementIntegralVariablePostprocessor
    variable = heat_source
  []
  [fluid_heat_source]
    type = ElementIntegralVariablePostprocessor
    variable = heat_source
    block = '2'
  []
  [solid_heat_source]
    type = ElementIntegralVariablePostprocessor
    variable = heat_source
    block = '1 3'
  []
[]

[Outputs]
  exodus = true
[]
