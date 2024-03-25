# Define an abstract type
abstract type AbstractGenericDatToMat end

# Define a generic struct for data to matrix conversion
struct GenericDatToMat <: AbstractGenericDatToMat end

# Define a struct for cell age properties
struct CellAgeProperties
    time
    location_index
    cell_centre_coord_x
    cell_centre_coord_y
    cell_centre_coord_z
    cell_age
end

# Define a struct for cell scaling properties
struct CellScalingProperties
    time
    location_index
    cell_id
    cell_centre_coord_x
    cell_centre_coord_y
    cell_centre_coord_z
    cell_radius
    cell_length
    unknown_value
end

# Define a struct for cell orientation properties
struct CellOrientationProperties
    time
    location_index
    cell_id
    cell_centre_coord_x
    cell_centre_coord_y
    cell_centre_coord_z
    cell_orient_direction_x
    cell_orient_direction_y
    cell_orient_direction_z
end

# Define a struct for machine state cell properties
struct MachineStateCellProperties
    time
    location_index
    cell_id
    cell_type_label
    number_machines_state_one
    number_machines_state_two
    number_machines_state_three
    number_neighbours_different_label
end

# Define a struct for machine data properties
struct MachineDataProperties
    time
    cell_id
    cell_label
    machine_id
    machine_state
    machine_coord_x
    machine_coord_y
    machine_coord_z
end
