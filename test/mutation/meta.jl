import NaiveNASlib
import NaiveNASlib:reset_in!, reset_out!
import InteractiveUtils:subtypes

using Test

@testset "Vertex mutation operations" begin

    expectedtype(t::Type{<:MutationOp}) = Integer
    expectedtype(t::Type{IoIndices}) = AbstractArray{<:Integer,1}

    @testset "Method contracts" begin
        for subtype in implementations(MutationOp)
            @info "test method contracts for MutationOp $subtype"
            @test hasmethod(Δnin, (subtype,expectedtype(subtype)))
            @test hasmethod(Δnout, (subtype, expectedtype(subtype)))
        end

        for subtype in implementations(MutationState)
            @info "test method contracts for MutationState $subtype"
            @test hasmethod(nin, (subtype,))
            @test hasmethod(nout, (subtype,))
        end
    end

    @testset "InvSize" begin
        size = InvSize(3)
        @test nin(size) == 3
        @test nout(size) == 3

        Δnin(size, 2)
        @test nin(size) == 5
        @test nout(size) == 5

        Δnout(size, -3)
        @test nin(size) == 2
        @test nout(size) == 2

        @test_throws AssertionError Δnin(size, 1,2)
    end

    @testset "IoSize" begin
        size = IoSize(3, 4)
        @test nin(size) == [3]
        @test nout(size) == 4

        Δnin(size, -1)
        @test nin(size) == [2]
        @test nout(size) == 4

        Δnout(size, 2)
        @test nin(size) == [2]
        @test nout(size) == 6

        size = IoSize([2, 3, 4], 5)
        @test nin(size) == [2, 3, 4]

        Δnin(size, 1,-2, 3)
        @test nin(size) == [3, 1 ,7]
    end

    @testset "IoIncies" begin
        inds = IoIndices([3,4], 5)

        @test nin(inds) == [3, 4]
        @test nout(inds) == 5

        Δnin(inds, [1,2], [2,3,4])
        @test nin(inds) == [2, 3]
        @test nout(inds) == 5
        @test inds.in == [[1, 2], [2,3,4]]

        reset_in!(inds)
        @test inds.in == [[1, 2], [1,2,3]]

        Δnout(inds, [2,4])
        @test nin(inds) == [2, 3]
        @test nout(inds) == 2
        @test inds.out == [2, 4]

        reset_out!(inds)
        @test inds.out == [1, 2]
    end

end
