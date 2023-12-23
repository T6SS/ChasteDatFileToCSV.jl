using ChasteDatFileToCSV
using Test


data_dir = "test/"
data_names = ("cellscaling","cellages","machinedata","machinestate","cellorientation")
data_suffix = ".dat"
path = string.(data_names,data_suffix)


data_df = get_cell_dataframe.(path)

function test_is_loaded_data_emptydata_df(data_df)
    @test !isempty(data_df)
end

function test_each_loaded_data_has_specific_column(data_df)
    @test any(contains.(data_df[1] |> names,"cell_length"))
    @test any(contains.(data_df[2] |> names,"cell_age"))
    @test any(contains.(data_df[3] |> names,"machine_state"))
    @test any(contains.(data_df[4] |> names,"cell_type_label"))
    @test any(contains.(data_df[5] |> names,"cell_orient_direction"))
end

@testset "test_is_loaded_data_emptydata_df" begin
    test_is_loaded_data_emptydata_df(data_df)
end

@testset "test_each_loaded_data_has_specific_column" begin
    test_each_loaded_data_has_specific_column(data_df)
end

