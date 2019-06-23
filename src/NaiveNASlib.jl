module NaiveNASlib

using LightGraphs
using DataStructures
using Statistics
# For solving diophantine equations which pop up here and there when mutating size under constraints
using AbstractAlgebra
using LinearAlgebra
using Base.CoreLogging


export
#Interface
AbstractVertex, AbstractMutationVertex, MutationOp, MutationState,

# Vertex
InputVertex, CompVertex, inputs, outputs,

# Information strings
infostr, name, RawInfoStr, NameInfoStr, InputsInfoStr, OutputsInfoStr, SizeInfoStr, MutationTraitInfoStr, ComposedInfoStr, NameAndInputsInfoStr, NinInfoStr, NoutInfoStr, NameAndIOInfoStr, FullInfoStr,MutationSizeTraitInfoStr,

# Computation graph
CompGraph, output!,flatten,

# Mutation operations
#State
InvSize, IoSize, InvIndices, IoIndices, NoOp, nin, nout, Δnin, Δnout, clone, op,

# Mutation vertex
base, InputSizeVertex, OutputsVertex, AbsorbVertex, StackingVertex, InvariantVertex, MutationVertex,

# Mutation traits
trait, MutationTrait, NamedTrait, Immutable, MutationSizeTrait, SizeAbsorb, SizeStack, SizeInvariant, SizeChangeLogger,

# Size util
minΔnoutfactor, minΔninfactor, minΔnoutfactor_only_for, minΔninfactor_only_for, findterminating,

# Connectivity mutation
remove!, RemoveStrategy, insert!, create_edge!, remove_edge!,

# Align size strategies, e.g what to do with sizes of vertices connected to a removed vertex
AbstractAlignSizeStrategy, IncreaseSmaller, DecreaseBigger, AlignSizeBoth, ChangeNinOfOutputs, AdjustToCurrentSize, FailAlignSizeError, FailAlignSizeWarn, FailAlignSizeRevert, NoSizeChange,

# Connect strategies
AbstractConnectStrategy, ConnectAll, ConnectNone,

# apply mutation
mutate_inputs, mutate_outputs, apply_mutation

include("vertex.jl")
include("compgraph.jl")

include("mutation/op.jl")
include("mutation/vertex.jl")
include("mutation/size.jl")
include("mutation/apply.jl")

include("mutation/structure.jl")



end # module
