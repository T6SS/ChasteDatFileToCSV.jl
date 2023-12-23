# Define a function to determine the type and number of non-time values based on the path
function get_type_non_time_values(path)
    contains(path,"cellscaling") ? (type = CellScalingProperties, non_time_values = 8) :
    contains(path,"cellages") ?  (type = CellAgeProperties, non_time_values = 5) :
    contains(path,"machinedata") ? (type = MachineDataProperties, non_time_values = 7) :
    contains(path,"machinestate") ? (type = MachineStateCellProperties, non_time_values = 7) :
    contains(path,"cellorientation") ? (type = CellOrientationProperties, non_time_values = 8) :
    error("Current cell reading needs to be cell: scaling, age, orientation or machine: state,data")
end

# Define a function to process cell population data and convert it into a vector of cells
function get_cell_data(GenericDatToMat, cell_population_data::Matrix, number_non_time_values)
    # ... (comments within the function to explain different steps)
end

# Define a function to convert a vector of data into a vector of a specific type
function convert_vec_mat_vec_type(type, mat)
    map(x -> type(x...), mat)
end

# Define a function to create a raw DataFrame from a vector of a specific type
function create_raw_dataframe(type, vector_type_data)
    df = DataFrame()
    for f in fieldnames(type)
        df[!, Symbol(f)] = getfield.(vector_type_data, f)
    end
    return df
end

# Define a function to shift simulation time to start from zero
function shift_simulation_time_zero_start(data)
    @chain data begin
        @transform :time = :time .- :time[1]
    end
end

# Define a function to get a DataFrame from a given path
function get_cell_dataframe(path)
    data_type, number_non_time_values = get_type_non_time_values(path)

    @chain path begin
        readdlm(_)
        get_cell_data(GenericDatToMat, _, number_non_time_values)
        convert_vec_mat_vec_type(data_type, _)
        create_raw_dataframe(data_type, _)
        shift_simulation_time_zero_start(_)
    end
end
