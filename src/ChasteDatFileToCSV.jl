##################################################################
# Filename  : ChasteDatFileToCSV.jl
# Author    : Jonathan Miller
# Date      : 2023-12-23
# Aim       : aim_script
#           : Take .dat files produced by chaste
#           : and write to CSV files
##################################################################


module ChasteDatFileToCSV

    using Reexport
    @reexport using DelimitedFiles
    @reexport using Revise
    @reexport using Chain
    @reexport using DataFrames
    @reexport using DataFramesMeta

    export  
        GenericDatToMat,
        CellAgeProperties,
        CellScalingProperties,
        CellOrientationProperties,
        MachineStateCellProperties,
        MachineDataProperties,
        get_type_non_time_values,
        get_cell_data,
        convert_vec_mat_vec_type,
        create_raw_dataframe,
        shift_simulation_time_zero_start,
        get_cell_dataframe


# cell scaling
# time, location_index, cell_id, 
struct GenericDatToMat end

struct CellAgeProperties 
    time
    location_index
    cell_centre_coord_x  
    cell_centre_coord_y  
    cell_centre_coord_z  
    cell_age
end 

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


function get_type_non_time_values(path)
    contains(path,"cellscaling") ? (type = CellScalingProperties, non_time_values = 8) :
    contains(path,"cellages") ?  (type = CellAgeProperties, non_time_values = 5) :
    contains(path,"machinedata") ? (type = MachineDataProperties, non_time_values = 7) :
    contains(path,"machinestate") ? (type = MachineStateCellProperties, non_time_values = 7) :
    contains(path,"cellorientation") ? (type = CellOrientationProperties, non_time_values = 8) :
    error("Current cell reading needs to be cell: scaling, age, orientation or machine: state,data")
end


function get_cell_data(
    GenericDatToMat,
    cell_population_data::Matrix,
    number_non_time_values)
    
    # Gather properties of cells 
    number_cell_properties = number_non_time_values
    cell_property_index_space = number_cell_properties - 1
    total_number_cells = Int((size(cell_population_data,2)-1)/number_cell_properties)
    total_number_time_steps = size(cell_population_data,1)
    
    # Separate time vector and state properties
    simulation_time_only = cell_population_data[:,1]
    simulation_no_time = cell_population_data[:,2:end]


    # Separate each cells across each rows
    # Get index of first and last cell properties
    cell_block_per_row = []
    for i in 1:total_number_cells
        first = number_cell_properties*i - cell_property_index_space
        push!(cell_block_per_row,first)
        second = number_cell_properties*i
        push!(cell_block_per_row,second)
    end


    
    # Separate each cell at each time step into a vector
    cells_data = []
    for j = 1:total_number_time_steps, i = 1:total_number_cells
        first = 2*i - 1
        second = 2*i
        cell_data = simulation_no_time[j,cell_block_per_row[first]:cell_block_per_row[second]]
        cell_time_data = vcat(simulation_time_only[j],cell_data)
        push!(cells_data,cell_time_data)
    end

    # Get cell data size counting at each time step
    size_cell_data = size(cells_data,1)

    # Get cell properties without time present
    non_time_cells = [i[2:end] for i in cells_data]
    
    # Assert that the intersection of checking empty rows is not empty
    # Essentially testing the data read is not empty as a whole
    empty_machine_vec = map(x->!all(isempty.(x)),non_time_cells)
     
     !any(empty_machine_vec) && error("Population starts smaller than it finishes, there should be empty cells")

    # Find the indices where without time we find empty vectors
    # Remove empty vectors
    # Assert no empty cell remain
    empty_indx = findall(map(x->all(isempty.(x)),non_time_cells))
    non_zero_elements = [cells_data[i] for i = 1:size_cell_data if i ∉ empty_indx]
    !all([all([!isempty(j) for j in i]) for i in non_zero_elements]) && error("No one of the elements per time should be empty")

    # Map each vectory to the MachineStateCellProperties struct
    #cell_properties = map(x -> CellAgeProperties(x...),non_zero_elements)
    return non_zero_elements
end

function convert_vec_mat_vec_type(type,mat)
    map(x -> type(x...),mat)
end

function create_raw_dataframe(type,vector_type_data)
    df = DataFrame()
    for f in fieldnames(type)
        df[!,Symbol(f)] = getfield.(vector_type_data, f)
    end
    return df
end

function shift_simulation_time_zero_start(data)
    @chain data begin
        @transform :time = :time .- :time[1]
    end
end



function get_cell_dataframe(path)
    data_type, number_non_time_values = get_type_non_time_values(path)

    @chain path begin
        readdlm(_)
        get_cell_data(GenericDatToMat,_,number_non_time_values)
        convert_vec_mat_vec_type(data_type,_)
        create_raw_dataframe(data_type,_)
        shift_simulation_time_zero_start(_)
    end
end

end
