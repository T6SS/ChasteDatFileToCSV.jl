module ChasteDatFileToCSV
##################################################################
# Filename  : ChasteDatFileToCSV.jl
# Author    : Jonathan Miller
# Date      : 2023-12-23
# Aim       : aim_script
#           : Take .dat files produced by chaste
#           : and write to CSV files
##################################################################


    using DelimitedFiles
    using Revise
    using Chain
    using DataFrames
    using DataFramesMeta

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


    include("structs_and_types.jl")
    include("functions.jl")

end
