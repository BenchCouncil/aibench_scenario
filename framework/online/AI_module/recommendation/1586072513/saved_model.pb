??
??
:
Add
x"T
y"T
z"T"
Ttype:
2	
x
Assign
ref"T?

value"T

output_ref"T?"	
Ttype"
validate_shapebool("
use_lockingbool(?
B
AssignVariableOp
resource
value"dtype"
dtypetype?
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
p
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:
	2
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(?
=
Mul
x"T
y"T
z"T"
Ttype:
2	?

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
~
RandomUniform

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	?
@
ReadVariableOp
resource
value"dtype"
dtypetype?
E
Relu
features"T
activations"T"
Ttype:
2	
?
ResourceGather
resource
indices"Tindices
output"dtype"
validate_indicesbool("
dtypetype"
Tindicestype:
2	?
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
H
ShardedFilename
basename	
shard

num_shards
filename
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
:
Sub
x"T
y"T
z"T"
Ttype:
2	
q
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape?
9
VarIsInitializedOp
resource
is_initialized
?
s

VariableV2
ref"dtype?"
shapeshape"
dtypetype"
	containerstring "
shared_namestring ?"serve*1.11.02
b'unknown'8??

global_step/Initializer/zerosConst*
_class
loc:@global_step*
value	B	 R *
dtype0	*
_output_shapes
: 
k
global_step
VariableV2*
_output_shapes
: *
shape: *
_class
loc:@global_step*
dtype0	
?
global_step/AssignAssignglobal_stepglobal_step/Initializer/zeros*
T0	*
_class
loc:@global_step*
_output_shapes
: 
j
global_step/readIdentityglobal_step*
T0	*
_class
loc:@global_step*
_output_shapes
: 
V
PlaceholderPlaceholder*
dtype0	*
_output_shapes	
:?*
shape:?
X
Placeholder_1Placeholder*
dtype0	*
_output_shapes	
:?*
shape:?
P
CastCastPlaceholder_1*

SrcT0	*
_output_shapes	
:?*

DstT0
?
5embedding/embeddings/Initializer/random_uniform/shapeConst*'
_class
loc:@embedding/embeddings*
valueB"?  @   *
dtype0*
_output_shapes
:
?
3embedding/embeddings/Initializer/random_uniform/minConst*
dtype0*
_output_shapes
: *'
_class
loc:@embedding/embeddings*
valueB
 *1k ?
?
3embedding/embeddings/Initializer/random_uniform/maxConst*
_output_shapes
: *'
_class
loc:@embedding/embeddings*
valueB
 *1k =*
dtype0
?
=embedding/embeddings/Initializer/random_uniform/RandomUniformRandomUniform5embedding/embeddings/Initializer/random_uniform/shape*
_output_shapes
:	?/@*
T0*'
_class
loc:@embedding/embeddings*
dtype0
?
3embedding/embeddings/Initializer/random_uniform/subSub3embedding/embeddings/Initializer/random_uniform/max3embedding/embeddings/Initializer/random_uniform/min*
T0*'
_class
loc:@embedding/embeddings*
_output_shapes
: 
?
3embedding/embeddings/Initializer/random_uniform/mulMul=embedding/embeddings/Initializer/random_uniform/RandomUniform3embedding/embeddings/Initializer/random_uniform/sub*
T0*'
_class
loc:@embedding/embeddings*
_output_shapes
:	?/@
?
/embedding/embeddings/Initializer/random_uniformAdd3embedding/embeddings/Initializer/random_uniform/mul3embedding/embeddings/Initializer/random_uniform/min*
T0*'
_class
loc:@embedding/embeddings*
_output_shapes
:	?/@
?
embedding/embeddingsVarHandleOp*'
_class
loc:@embedding/embeddings*
dtype0*
_output_shapes
: *
shape:	?/@*%
shared_nameembedding/embeddings
y
5embedding/embeddings/IsInitialized/VarIsInitializedOpVarIsInitializedOpembedding/embeddings*
_output_shapes
: 
?
embedding/embeddings/AssignAssignVariableOpembedding/embeddings/embedding/embeddings/Initializer/random_uniform*'
_class
loc:@embedding/embeddings*
dtype0
?
(embedding/embeddings/Read/ReadVariableOpReadVariableOpembedding/embeddings*'
_class
loc:@embedding/embeddings*
dtype0*
_output_shapes
:	?/@
T
embedding/ConstConst*
_output_shapes
: *
valueB
 *    *
dtype0
?
.embedding/embedding_lookup/Read/ReadVariableOpReadVariableOpembedding/embeddings*
dtype0*
_output_shapes
:	?/@
?
#embedding/embedding_lookup/IdentityIdentity.embedding/embedding_lookup/Read/ReadVariableOp*
_output_shapes
:	?/@*
T0
?
embedding/embedding_lookupResourceGatherembedding/embeddingsPlaceholder*A
_class7
53loc:@embedding/embedding_lookup/Read/ReadVariableOp*
dtype0*
_output_shapes
:	?@*
Tindices0	
?
%embedding/embedding_lookup/Identity_1Identityembedding/embedding_lookup*
_output_shapes
:	?@*
T0*A
_class7
53loc:@embedding/embedding_lookup/Read/ReadVariableOp
?
%embedding/embedding_lookup/Identity_2Identity%embedding/embedding_lookup/Identity_1*
T0*
_output_shapes
:	?@
?
7embedding_1/embeddings/Initializer/random_uniform/shapeConst*)
_class
loc:@embedding_1/embeddings*
valueB"z  @   *
dtype0*
_output_shapes
:
?
5embedding_1/embeddings/Initializer/random_uniform/minConst*)
_class
loc:@embedding_1/embeddings*
valueB
 *?g#?*
dtype0*
_output_shapes
: 
?
5embedding_1/embeddings/Initializer/random_uniform/maxConst*
dtype0*
_output_shapes
: *)
_class
loc:@embedding_1/embeddings*
valueB
 *?g#=
?
?embedding_1/embeddings/Initializer/random_uniform/RandomUniformRandomUniform7embedding_1/embeddings/Initializer/random_uniform/shape*
T0*)
_class
loc:@embedding_1/embeddings*
dtype0*
_output_shapes
:	?@
?
5embedding_1/embeddings/Initializer/random_uniform/subSub5embedding_1/embeddings/Initializer/random_uniform/max5embedding_1/embeddings/Initializer/random_uniform/min*
_output_shapes
: *
T0*)
_class
loc:@embedding_1/embeddings
?
5embedding_1/embeddings/Initializer/random_uniform/mulMul?embedding_1/embeddings/Initializer/random_uniform/RandomUniform5embedding_1/embeddings/Initializer/random_uniform/sub*
T0*)
_class
loc:@embedding_1/embeddings*
_output_shapes
:	?@
?
1embedding_1/embeddings/Initializer/random_uniformAdd5embedding_1/embeddings/Initializer/random_uniform/mul5embedding_1/embeddings/Initializer/random_uniform/min*
_output_shapes
:	?@*
T0*)
_class
loc:@embedding_1/embeddings
?
embedding_1/embeddingsVarHandleOp*)
_class
loc:@embedding_1/embeddings*
dtype0*
_output_shapes
: *
shape:	?@*'
shared_nameembedding_1/embeddings
}
7embedding_1/embeddings/IsInitialized/VarIsInitializedOpVarIsInitializedOpembedding_1/embeddings*
_output_shapes
: 
?
embedding_1/embeddings/AssignAssignVariableOpembedding_1/embeddings1embedding_1/embeddings/Initializer/random_uniform*)
_class
loc:@embedding_1/embeddings*
dtype0
?
*embedding_1/embeddings/Read/ReadVariableOpReadVariableOpembedding_1/embeddings*)
_class
loc:@embedding_1/embeddings*
dtype0*
_output_shapes
:	?@
V
embedding_1/ConstConst*
_output_shapes
: *
valueB
 *    *
dtype0
?
0embedding_1/embedding_lookup/Read/ReadVariableOpReadVariableOpembedding_1/embeddings*
_output_shapes
:	?@*
dtype0
?
%embedding_1/embedding_lookup/IdentityIdentity0embedding_1/embedding_lookup/Read/ReadVariableOp*
T0*
_output_shapes
:	?@
?
embedding_1/embedding_lookupResourceGatherembedding_1/embeddingsCast*C
_class9
75loc:@embedding_1/embedding_lookup/Read/ReadVariableOp*
dtype0*
_output_shapes
:	?@*
Tindices0
?
'embedding_1/embedding_lookup/Identity_1Identityembedding_1/embedding_lookup*C
_class9
75loc:@embedding_1/embedding_lookup/Read/ReadVariableOp*
_output_shapes
:	?@*
T0
?
'embedding_1/embedding_lookup/Identity_2Identity'embedding_1/embedding_lookup/Identity_1*
T0*
_output_shapes
:	?@
?
multiply/mulMul%embedding/embedding_lookup/Identity_2'embedding_1/embedding_lookup/Identity_2*
_output_shapes
:	?@*
T0
?
7embedding_2/embeddings/Initializer/random_uniform/shapeConst*)
_class
loc:@embedding_2/embeddings*
valueB"?  ?   *
dtype0*
_output_shapes
:
?
5embedding_2/embeddings/Initializer/random_uniform/minConst*)
_class
loc:@embedding_2/embeddings*
valueB
 *`???*
dtype0*
_output_shapes
: 
?
5embedding_2/embeddings/Initializer/random_uniform/maxConst*
dtype0*
_output_shapes
: *)
_class
loc:@embedding_2/embeddings*
valueB
 *`??<
?
?embedding_2/embeddings/Initializer/random_uniform/RandomUniformRandomUniform7embedding_2/embeddings/Initializer/random_uniform/shape*
T0*)
_class
loc:@embedding_2/embeddings*
dtype0* 
_output_shapes
:
?/?
?
5embedding_2/embeddings/Initializer/random_uniform/subSub5embedding_2/embeddings/Initializer/random_uniform/max5embedding_2/embeddings/Initializer/random_uniform/min*
_output_shapes
: *
T0*)
_class
loc:@embedding_2/embeddings
?
5embedding_2/embeddings/Initializer/random_uniform/mulMul?embedding_2/embeddings/Initializer/random_uniform/RandomUniform5embedding_2/embeddings/Initializer/random_uniform/sub*
T0*)
_class
loc:@embedding_2/embeddings* 
_output_shapes
:
?/?
?
1embedding_2/embeddings/Initializer/random_uniformAdd5embedding_2/embeddings/Initializer/random_uniform/mul5embedding_2/embeddings/Initializer/random_uniform/min*
T0*)
_class
loc:@embedding_2/embeddings* 
_output_shapes
:
?/?
?
embedding_2/embeddingsVarHandleOp*'
shared_nameembedding_2/embeddings*)
_class
loc:@embedding_2/embeddings*
dtype0*
_output_shapes
: *
shape:
?/?
}
7embedding_2/embeddings/IsInitialized/VarIsInitializedOpVarIsInitializedOpembedding_2/embeddings*
_output_shapes
: 
?
embedding_2/embeddings/AssignAssignVariableOpembedding_2/embeddings1embedding_2/embeddings/Initializer/random_uniform*
dtype0*)
_class
loc:@embedding_2/embeddings
?
*embedding_2/embeddings/Read/ReadVariableOpReadVariableOpembedding_2/embeddings*)
_class
loc:@embedding_2/embeddings*
dtype0* 
_output_shapes
:
?/?
V
embedding_2/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 
?
0embedding_2/embedding_lookup/Read/ReadVariableOpReadVariableOpembedding_2/embeddings*
dtype0* 
_output_shapes
:
?/?
?
%embedding_2/embedding_lookup/IdentityIdentity0embedding_2/embedding_lookup/Read/ReadVariableOp* 
_output_shapes
:
?/?*
T0
?
embedding_2/embedding_lookupResourceGatherembedding_2/embeddingsPlaceholder*
Tindices0	*C
_class9
75loc:@embedding_2/embedding_lookup/Read/ReadVariableOp*
dtype0* 
_output_shapes
:
??
?
'embedding_2/embedding_lookup/Identity_1Identityembedding_2/embedding_lookup*
T0*C
_class9
75loc:@embedding_2/embedding_lookup/Read/ReadVariableOp* 
_output_shapes
:
??
?
'embedding_2/embedding_lookup/Identity_2Identity'embedding_2/embedding_lookup/Identity_1* 
_output_shapes
:
??*
T0
?
7embedding_3/embeddings/Initializer/random_uniform/shapeConst*)
_class
loc:@embedding_3/embeddings*
valueB"z  ?   *
dtype0*
_output_shapes
:
?
5embedding_3/embeddings/Initializer/random_uniform/minConst*)
_class
loc:@embedding_3/embeddings*
valueB
 *	"?*
dtype0*
_output_shapes
: 
?
5embedding_3/embeddings/Initializer/random_uniform/maxConst*
_output_shapes
: *)
_class
loc:@embedding_3/embeddings*
valueB
 *	"=*
dtype0
?
?embedding_3/embeddings/Initializer/random_uniform/RandomUniformRandomUniform7embedding_3/embeddings/Initializer/random_uniform/shape* 
_output_shapes
:
??*
T0*)
_class
loc:@embedding_3/embeddings*
dtype0
?
5embedding_3/embeddings/Initializer/random_uniform/subSub5embedding_3/embeddings/Initializer/random_uniform/max5embedding_3/embeddings/Initializer/random_uniform/min*
T0*)
_class
loc:@embedding_3/embeddings*
_output_shapes
: 
?
5embedding_3/embeddings/Initializer/random_uniform/mulMul?embedding_3/embeddings/Initializer/random_uniform/RandomUniform5embedding_3/embeddings/Initializer/random_uniform/sub*)
_class
loc:@embedding_3/embeddings* 
_output_shapes
:
??*
T0
?
1embedding_3/embeddings/Initializer/random_uniformAdd5embedding_3/embeddings/Initializer/random_uniform/mul5embedding_3/embeddings/Initializer/random_uniform/min*
T0*)
_class
loc:@embedding_3/embeddings* 
_output_shapes
:
??
?
embedding_3/embeddingsVarHandleOp*)
_class
loc:@embedding_3/embeddings*
dtype0*
_output_shapes
: *
shape:
??*'
shared_nameembedding_3/embeddings
}
7embedding_3/embeddings/IsInitialized/VarIsInitializedOpVarIsInitializedOpembedding_3/embeddings*
_output_shapes
: 
?
embedding_3/embeddings/AssignAssignVariableOpembedding_3/embeddings1embedding_3/embeddings/Initializer/random_uniform*)
_class
loc:@embedding_3/embeddings*
dtype0
?
*embedding_3/embeddings/Read/ReadVariableOpReadVariableOpembedding_3/embeddings*)
_class
loc:@embedding_3/embeddings*
dtype0* 
_output_shapes
:
??
V
embedding_3/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 
?
0embedding_3/embedding_lookup/Read/ReadVariableOpReadVariableOpembedding_3/embeddings* 
_output_shapes
:
??*
dtype0
?
%embedding_3/embedding_lookup/IdentityIdentity0embedding_3/embedding_lookup/Read/ReadVariableOp* 
_output_shapes
:
??*
T0
?
embedding_3/embedding_lookupResourceGatherembedding_3/embeddingsCast*
Tindices0*C
_class9
75loc:@embedding_3/embedding_lookup/Read/ReadVariableOp*
dtype0* 
_output_shapes
:
??
?
'embedding_3/embedding_lookup/Identity_1Identityembedding_3/embedding_lookup*
T0*C
_class9
75loc:@embedding_3/embedding_lookup/Read/ReadVariableOp* 
_output_shapes
:
??
?
'embedding_3/embedding_lookup/Identity_2Identity'embedding_3/embedding_lookup/Identity_1*
T0* 
_output_shapes
:
??
Y
concatenate/concat/axisConst*
value	B :*
dtype0*
_output_shapes
: 
?
concatenate/concatConcatV2'embedding_2/embedding_lookup/Identity_2'embedding_3/embedding_lookup/Identity_2concatenate/concat/axis* 
_output_shapes
:
??*
T0*
N
?
-dense/kernel/Initializer/random_uniform/shapeConst*
_class
loc:@dense/kernel*
valueB"      *
dtype0*
_output_shapes
:
?
+dense/kernel/Initializer/random_uniform/minConst*
_class
loc:@dense/kernel*
valueB
 *׳ݽ*
dtype0*
_output_shapes
: 
?
+dense/kernel/Initializer/random_uniform/maxConst*
_class
loc:@dense/kernel*
valueB
 *׳?=*
dtype0*
_output_shapes
: 
?
5dense/kernel/Initializer/random_uniform/RandomUniformRandomUniform-dense/kernel/Initializer/random_uniform/shape*
T0*
_class
loc:@dense/kernel*
dtype0* 
_output_shapes
:
??
?
+dense/kernel/Initializer/random_uniform/subSub+dense/kernel/Initializer/random_uniform/max+dense/kernel/Initializer/random_uniform/min*
_output_shapes
: *
T0*
_class
loc:@dense/kernel
?
+dense/kernel/Initializer/random_uniform/mulMul5dense/kernel/Initializer/random_uniform/RandomUniform+dense/kernel/Initializer/random_uniform/sub* 
_output_shapes
:
??*
T0*
_class
loc:@dense/kernel
?
'dense/kernel/Initializer/random_uniformAdd+dense/kernel/Initializer/random_uniform/mul+dense/kernel/Initializer/random_uniform/min*
T0*
_class
loc:@dense/kernel* 
_output_shapes
:
??
?
dense/kernelVarHandleOp*
_class
loc:@dense/kernel*
dtype0*
_output_shapes
: *
shape:
??*
shared_namedense/kernel
i
-dense/kernel/IsInitialized/VarIsInitializedOpVarIsInitializedOpdense/kernel*
_output_shapes
: 
?
dense/kernel/AssignAssignVariableOpdense/kernel'dense/kernel/Initializer/random_uniform*
_class
loc:@dense/kernel*
dtype0
?
 dense/kernel/Read/ReadVariableOpReadVariableOpdense/kernel*
_class
loc:@dense/kernel*
dtype0* 
_output_shapes
:
??
P
dense/ConstConst*
dtype0*
_output_shapes
: *
valueB
 *    
?
dense/bias/Initializer/zerosConst*
dtype0*
_output_shapes	
:?*
_class
loc:@dense/bias*
valueB?*    
?

dense/biasVarHandleOp*
shared_name
dense/bias*
_class
loc:@dense/bias*
dtype0*
_output_shapes
: *
shape:?
e
+dense/bias/IsInitialized/VarIsInitializedOpVarIsInitializedOp
dense/bias*
_output_shapes
: 
{
dense/bias/AssignAssignVariableOp
dense/biasdense/bias/Initializer/zeros*
_class
loc:@dense/bias*
dtype0
?
dense/bias/Read/ReadVariableOpReadVariableOp
dense/bias*
_class
loc:@dense/bias*
dtype0*
_output_shapes	
:?
j
dense/MatMul/ReadVariableOpReadVariableOpdense/kernel*
dtype0* 
_output_shapes
:
??
r
dense/MatMulMatMulconcatenate/concatdense/MatMul/ReadVariableOp*
T0* 
_output_shapes
:
??
d
dense/BiasAdd/ReadVariableOpReadVariableOp
dense/bias*
dtype0*
_output_shapes	
:?
o
dense/BiasAddBiasAdddense/MatMuldense/BiasAdd/ReadVariableOp*
T0* 
_output_shapes
:
??
L

dense/ReluReludense/BiasAdd* 
_output_shapes
:
??*
T0
?
/dense_1/kernel/Initializer/random_uniform/shapeConst*!
_class
loc:@dense_1/kernel*
valueB"   ?   *
dtype0*
_output_shapes
:
?
-dense_1/kernel/Initializer/random_uniform/minConst*!
_class
loc:@dense_1/kernel*
valueB
 *   ?*
dtype0*
_output_shapes
: 
?
-dense_1/kernel/Initializer/random_uniform/maxConst*!
_class
loc:@dense_1/kernel*
valueB
 *   >*
dtype0*
_output_shapes
: 
?
7dense_1/kernel/Initializer/random_uniform/RandomUniformRandomUniform/dense_1/kernel/Initializer/random_uniform/shape*
T0*!
_class
loc:@dense_1/kernel*
dtype0* 
_output_shapes
:
??
?
-dense_1/kernel/Initializer/random_uniform/subSub-dense_1/kernel/Initializer/random_uniform/max-dense_1/kernel/Initializer/random_uniform/min*!
_class
loc:@dense_1/kernel*
_output_shapes
: *
T0
?
-dense_1/kernel/Initializer/random_uniform/mulMul7dense_1/kernel/Initializer/random_uniform/RandomUniform-dense_1/kernel/Initializer/random_uniform/sub*
T0*!
_class
loc:@dense_1/kernel* 
_output_shapes
:
??
?
)dense_1/kernel/Initializer/random_uniformAdd-dense_1/kernel/Initializer/random_uniform/mul-dense_1/kernel/Initializer/random_uniform/min* 
_output_shapes
:
??*
T0*!
_class
loc:@dense_1/kernel
?
dense_1/kernelVarHandleOp*
dtype0*
_output_shapes
: *
shape:
??*
shared_namedense_1/kernel*!
_class
loc:@dense_1/kernel
m
/dense_1/kernel/IsInitialized/VarIsInitializedOpVarIsInitializedOpdense_1/kernel*
_output_shapes
: 
?
dense_1/kernel/AssignAssignVariableOpdense_1/kernel)dense_1/kernel/Initializer/random_uniform*!
_class
loc:@dense_1/kernel*
dtype0
?
"dense_1/kernel/Read/ReadVariableOpReadVariableOpdense_1/kernel*
dtype0* 
_output_shapes
:
??*!
_class
loc:@dense_1/kernel
R
dense_1/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 
?
dense_1/bias/Initializer/zerosConst*
_class
loc:@dense_1/bias*
valueB?*    *
dtype0*
_output_shapes	
:?
?
dense_1/biasVarHandleOp*
_output_shapes
: *
shape:?*
shared_namedense_1/bias*
_class
loc:@dense_1/bias*
dtype0
i
-dense_1/bias/IsInitialized/VarIsInitializedOpVarIsInitializedOpdense_1/bias*
_output_shapes
: 
?
dense_1/bias/AssignAssignVariableOpdense_1/biasdense_1/bias/Initializer/zeros*
_class
loc:@dense_1/bias*
dtype0
?
 dense_1/bias/Read/ReadVariableOpReadVariableOpdense_1/bias*
_class
loc:@dense_1/bias*
dtype0*
_output_shapes	
:?
n
dense_1/MatMul/ReadVariableOpReadVariableOpdense_1/kernel*
dtype0* 
_output_shapes
:
??
n
dense_1/MatMulMatMul
dense/Reludense_1/MatMul/ReadVariableOp*
T0* 
_output_shapes
:
??
h
dense_1/BiasAdd/ReadVariableOpReadVariableOpdense_1/bias*
dtype0*
_output_shapes	
:?
u
dense_1/BiasAddBiasAdddense_1/MatMuldense_1/BiasAdd/ReadVariableOp* 
_output_shapes
:
??*
T0
P
dense_1/ReluReludense_1/BiasAdd*
T0* 
_output_shapes
:
??
?
/dense_2/kernel/Initializer/random_uniform/shapeConst*!
_class
loc:@dense_2/kernel*
valueB"?   @   *
dtype0*
_output_shapes
:
?
-dense_2/kernel/Initializer/random_uniform/minConst*!
_class
loc:@dense_2/kernel*
valueB
 *?5?*
dtype0*
_output_shapes
: 
?
-dense_2/kernel/Initializer/random_uniform/maxConst*!
_class
loc:@dense_2/kernel*
valueB
 *?5>*
dtype0*
_output_shapes
: 
?
7dense_2/kernel/Initializer/random_uniform/RandomUniformRandomUniform/dense_2/kernel/Initializer/random_uniform/shape*
T0*!
_class
loc:@dense_2/kernel*
dtype0*
_output_shapes
:	?@
?
-dense_2/kernel/Initializer/random_uniform/subSub-dense_2/kernel/Initializer/random_uniform/max-dense_2/kernel/Initializer/random_uniform/min*
T0*!
_class
loc:@dense_2/kernel*
_output_shapes
: 
?
-dense_2/kernel/Initializer/random_uniform/mulMul7dense_2/kernel/Initializer/random_uniform/RandomUniform-dense_2/kernel/Initializer/random_uniform/sub*
_output_shapes
:	?@*
T0*!
_class
loc:@dense_2/kernel
?
)dense_2/kernel/Initializer/random_uniformAdd-dense_2/kernel/Initializer/random_uniform/mul-dense_2/kernel/Initializer/random_uniform/min*
_output_shapes
:	?@*
T0*!
_class
loc:@dense_2/kernel
?
dense_2/kernelVarHandleOp*!
_class
loc:@dense_2/kernel*
dtype0*
_output_shapes
: *
shape:	?@*
shared_namedense_2/kernel
m
/dense_2/kernel/IsInitialized/VarIsInitializedOpVarIsInitializedOpdense_2/kernel*
_output_shapes
: 
?
dense_2/kernel/AssignAssignVariableOpdense_2/kernel)dense_2/kernel/Initializer/random_uniform*!
_class
loc:@dense_2/kernel*
dtype0
?
"dense_2/kernel/Read/ReadVariableOpReadVariableOpdense_2/kernel*!
_class
loc:@dense_2/kernel*
dtype0*
_output_shapes
:	?@
R
dense_2/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 
?
dense_2/bias/Initializer/zerosConst*
_class
loc:@dense_2/bias*
valueB@*    *
dtype0*
_output_shapes
:@
?
dense_2/biasVarHandleOp*
shape:@*
shared_namedense_2/bias*
_class
loc:@dense_2/bias*
dtype0*
_output_shapes
: 
i
-dense_2/bias/IsInitialized/VarIsInitializedOpVarIsInitializedOpdense_2/bias*
_output_shapes
: 
?
dense_2/bias/AssignAssignVariableOpdense_2/biasdense_2/bias/Initializer/zeros*
_class
loc:@dense_2/bias*
dtype0
?
 dense_2/bias/Read/ReadVariableOpReadVariableOpdense_2/bias*
_class
loc:@dense_2/bias*
dtype0*
_output_shapes
:@
m
dense_2/MatMul/ReadVariableOpReadVariableOpdense_2/kernel*
_output_shapes
:	?@*
dtype0
o
dense_2/MatMulMatMuldense_1/Reludense_2/MatMul/ReadVariableOp*
_output_shapes
:	?@*
T0
g
dense_2/BiasAdd/ReadVariableOpReadVariableOpdense_2/bias*
dtype0*
_output_shapes
:@
t
dense_2/BiasAddBiasAdddense_2/MatMuldense_2/BiasAdd/ReadVariableOp*
_output_shapes
:	?@*
T0
O
dense_2/ReluReludense_2/BiasAdd*
T0*
_output_shapes
:	?@
[
concatenate_1/concat/axisConst*
value	B :*
dtype0*
_output_shapes
: 
?
concatenate_1/concatConcatV2multiply/muldense_2/Reluconcatenate_1/concat/axis*
N* 
_output_shapes
:
??*
T0
?
.rating/kernel/Initializer/random_uniform/shapeConst* 
_class
loc:@rating/kernel*
valueB"?      *
dtype0*
_output_shapes
:
?
,rating/kernel/Initializer/random_uniform/minConst*
_output_shapes
: * 
_class
loc:@rating/kernel*
valueB
 *q??*
dtype0
?
,rating/kernel/Initializer/random_uniform/maxConst* 
_class
loc:@rating/kernel*
valueB
 *q?>*
dtype0*
_output_shapes
: 
?
6rating/kernel/Initializer/random_uniform/RandomUniformRandomUniform.rating/kernel/Initializer/random_uniform/shape*
_output_shapes
:	?*
T0* 
_class
loc:@rating/kernel*
dtype0
?
,rating/kernel/Initializer/random_uniform/subSub,rating/kernel/Initializer/random_uniform/max,rating/kernel/Initializer/random_uniform/min*
T0* 
_class
loc:@rating/kernel*
_output_shapes
: 
?
,rating/kernel/Initializer/random_uniform/mulMul6rating/kernel/Initializer/random_uniform/RandomUniform,rating/kernel/Initializer/random_uniform/sub*
T0* 
_class
loc:@rating/kernel*
_output_shapes
:	?
?
(rating/kernel/Initializer/random_uniformAdd,rating/kernel/Initializer/random_uniform/mul,rating/kernel/Initializer/random_uniform/min*
T0* 
_class
loc:@rating/kernel*
_output_shapes
:	?
?
rating/kernelVarHandleOp* 
_class
loc:@rating/kernel*
dtype0*
_output_shapes
: *
shape:	?*
shared_namerating/kernel
k
.rating/kernel/IsInitialized/VarIsInitializedOpVarIsInitializedOprating/kernel*
_output_shapes
: 
?
rating/kernel/AssignAssignVariableOprating/kernel(rating/kernel/Initializer/random_uniform* 
_class
loc:@rating/kernel*
dtype0
?
!rating/kernel/Read/ReadVariableOpReadVariableOprating/kernel* 
_class
loc:@rating/kernel*
dtype0*
_output_shapes
:	?
?
rating/bias/Initializer/zerosConst*
_class
loc:@rating/bias*
valueB*    *
dtype0*
_output_shapes
:
?
rating/biasVarHandleOp*
_output_shapes
: *
shape:*
shared_namerating/bias*
_class
loc:@rating/bias*
dtype0
g
,rating/bias/IsInitialized/VarIsInitializedOpVarIsInitializedOprating/bias*
_output_shapes
: 

rating/bias/AssignAssignVariableOprating/biasrating/bias/Initializer/zeros*
_class
loc:@rating/bias*
dtype0
?
rating/bias/Read/ReadVariableOpReadVariableOprating/bias*
dtype0*
_output_shapes
:*
_class
loc:@rating/bias
k
rating/MatMul/ReadVariableOpReadVariableOprating/kernel*
dtype0*
_output_shapes
:	?
u
rating/MatMulMatMulconcatenate_1/concatrating/MatMul/ReadVariableOp*
T0*
_output_shapes
:	?
e
rating/BiasAdd/ReadVariableOpReadVariableOprating/bias*
dtype0*
_output_shapes
:
q
rating/BiasAddBiasAddrating/MatMulrating/BiasAdd/ReadVariableOp*
T0*
_output_shapes
:	?

initNoOp

init_all_tablesNoOp

init_1NoOp
4

group_depsNoOp^init^init_1^init_all_tables
P

save/ConstConst*
dtype0*
_output_shapes
: *
valueB Bmodel
?
save/StringJoin/inputs_1Const*<
value3B1 B+_temp_c94012df28ba4f53867f3c7a2340c4c8/part*
dtype0*
_output_shapes
: 
d
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
N*
_output_shapes
: 
Q
save/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
k
save/ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
value	B : *
dtype0
?
save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards"/device:CPU:0*
_output_shapes
: 
?
save/SaveV2/tensor_namesConst"/device:CPU:0*
dtype0*
_output_shapes
:*?
value?B?B
dense/biasBdense/kernelBdense_1/biasBdense_1/kernelBdense_2/biasBdense_2/kernelBembedding/embeddingsBembedding_1/embeddingsBembedding_2/embeddingsBembedding_3/embeddingsBglobal_stepBrating/biasBrating/kernel
?
save/SaveV2/shape_and_slicesConst"/device:CPU:0*
dtype0*
_output_shapes
:*-
value$B"B B B B B B B B B B B B B 
?
save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesdense/bias/Read/ReadVariableOp dense/kernel/Read/ReadVariableOp dense_1/bias/Read/ReadVariableOp"dense_1/kernel/Read/ReadVariableOp dense_2/bias/Read/ReadVariableOp"dense_2/kernel/Read/ReadVariableOp(embedding/embeddings/Read/ReadVariableOp*embedding_1/embeddings/Read/ReadVariableOp*embedding_2/embeddings/Read/ReadVariableOp*embedding_3/embeddings/Read/ReadVariableOpglobal_steprating/bias/Read/ReadVariableOp!rating/kernel/Read/ReadVariableOp"/device:CPU:0*
dtypes
2	
?
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2"/device:CPU:0*
T0*'
_class
loc:@save/ShardedFilename*
_output_shapes
: 
?
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency"/device:CPU:0*
T0*
N*
_output_shapes
:
u
save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const"/device:CPU:0
?
save/IdentityIdentity
save/Const^save/MergeV2Checkpoints^save/control_dependency"/device:CPU:0*
T0*
_output_shapes
: 
?
save/RestoreV2/tensor_namesConst"/device:CPU:0*?
value?B?B
dense/biasBdense/kernelBdense_1/biasBdense_1/kernelBdense_2/biasBdense_2/kernelBembedding/embeddingsBembedding_1/embeddingsBembedding_2/embeddingsBembedding_3/embeddingsBglobal_stepBrating/biasBrating/kernel*
dtype0*
_output_shapes
:
?
save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*-
value$B"B B B B B B B B B B B B B *
dtype0
?
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*H
_output_shapes6
4:::::::::::::*
dtypes
2	
N
save/Identity_1Identitysave/RestoreV2*
_output_shapes
:*
T0
S
save/AssignVariableOpAssignVariableOp
dense/biassave/Identity_1*
dtype0
P
save/Identity_2Identitysave/RestoreV2:1*
T0*
_output_shapes
:
W
save/AssignVariableOp_1AssignVariableOpdense/kernelsave/Identity_2*
dtype0
P
save/Identity_3Identitysave/RestoreV2:2*
_output_shapes
:*
T0
W
save/AssignVariableOp_2AssignVariableOpdense_1/biassave/Identity_3*
dtype0
P
save/Identity_4Identitysave/RestoreV2:3*
T0*
_output_shapes
:
Y
save/AssignVariableOp_3AssignVariableOpdense_1/kernelsave/Identity_4*
dtype0
P
save/Identity_5Identitysave/RestoreV2:4*
T0*
_output_shapes
:
W
save/AssignVariableOp_4AssignVariableOpdense_2/biassave/Identity_5*
dtype0
P
save/Identity_6Identitysave/RestoreV2:5*
_output_shapes
:*
T0
Y
save/AssignVariableOp_5AssignVariableOpdense_2/kernelsave/Identity_6*
dtype0
P
save/Identity_7Identitysave/RestoreV2:6*
T0*
_output_shapes
:
_
save/AssignVariableOp_6AssignVariableOpembedding/embeddingssave/Identity_7*
dtype0
P
save/Identity_8Identitysave/RestoreV2:7*
_output_shapes
:*
T0
a
save/AssignVariableOp_7AssignVariableOpembedding_1/embeddingssave/Identity_8*
dtype0
P
save/Identity_9Identitysave/RestoreV2:8*
T0*
_output_shapes
:
a
save/AssignVariableOp_8AssignVariableOpembedding_2/embeddingssave/Identity_9*
dtype0
Q
save/Identity_10Identitysave/RestoreV2:9*
T0*
_output_shapes
:
b
save/AssignVariableOp_9AssignVariableOpembedding_3/embeddingssave/Identity_10*
dtype0
v
save/AssignAssignglobal_stepsave/RestoreV2:10*
T0	*
_class
loc:@global_step*
_output_shapes
: 
R
save/Identity_11Identitysave/RestoreV2:11*
_output_shapes
:*
T0
X
save/AssignVariableOp_10AssignVariableOprating/biassave/Identity_11*
dtype0
R
save/Identity_12Identitysave/RestoreV2:12*
T0*
_output_shapes
:
Z
save/AssignVariableOp_11AssignVariableOprating/kernelsave/Identity_12*
dtype0
?
save/restore_shardNoOp^save/Assign^save/AssignVariableOp^save/AssignVariableOp_1^save/AssignVariableOp_10^save/AssignVariableOp_11^save/AssignVariableOp_2^save/AssignVariableOp_3^save/AssignVariableOp_4^save/AssignVariableOp_5^save/AssignVariableOp_6^save/AssignVariableOp_7^save/AssignVariableOp_8^save/AssignVariableOp_9
-
save/restore_allNoOp^save/restore_shard"<
save/Const:0save/Identity:0save/restore_all (5 @F8"?
	variables??
X
global_step:0global_step/Assignglobal_step/read:02global_step/Initializer/zeros:0
?
embedding/embeddings:0embedding/embeddings/Assign*embedding/embeddings/Read/ReadVariableOp:0(21embedding/embeddings/Initializer/random_uniform:08
?
embedding_1/embeddings:0embedding_1/embeddings/Assign,embedding_1/embeddings/Read/ReadVariableOp:0(23embedding_1/embeddings/Initializer/random_uniform:08
?
embedding_2/embeddings:0embedding_2/embeddings/Assign,embedding_2/embeddings/Read/ReadVariableOp:0(23embedding_2/embeddings/Initializer/random_uniform:08
?
embedding_3/embeddings:0embedding_3/embeddings/Assign,embedding_3/embeddings/Read/ReadVariableOp:0(23embedding_3/embeddings/Initializer/random_uniform:08
x
dense/kernel:0dense/kernel/Assign"dense/kernel/Read/ReadVariableOp:0(2)dense/kernel/Initializer/random_uniform:08
g
dense/bias:0dense/bias/Assign dense/bias/Read/ReadVariableOp:0(2dense/bias/Initializer/zeros:08
?
dense_1/kernel:0dense_1/kernel/Assign$dense_1/kernel/Read/ReadVariableOp:0(2+dense_1/kernel/Initializer/random_uniform:08
o
dense_1/bias:0dense_1/bias/Assign"dense_1/bias/Read/ReadVariableOp:0(2 dense_1/bias/Initializer/zeros:08
?
dense_2/kernel:0dense_2/kernel/Assign$dense_2/kernel/Read/ReadVariableOp:0(2+dense_2/kernel/Initializer/random_uniform:08
o
dense_2/bias:0dense_2/bias/Assign"dense_2/bias/Read/ReadVariableOp:0(2 dense_2/bias/Initializer/zeros:08
|
rating/kernel:0rating/kernel/Assign#rating/kernel/Read/ReadVariableOp:0(2*rating/kernel/Initializer/random_uniform:08
k
rating/bias:0rating/bias/Assign!rating/bias/Read/ReadVariableOp:0(2rating/bias/Initializer/zeros:08"%
saved_model_main_op


group_deps"?
trainable_variables??
?
embedding/embeddings:0embedding/embeddings/Assign*embedding/embeddings/Read/ReadVariableOp:0(21embedding/embeddings/Initializer/random_uniform:08
?
embedding_1/embeddings:0embedding_1/embeddings/Assign,embedding_1/embeddings/Read/ReadVariableOp:0(23embedding_1/embeddings/Initializer/random_uniform:08
?
embedding_2/embeddings:0embedding_2/embeddings/Assign,embedding_2/embeddings/Read/ReadVariableOp:0(23embedding_2/embeddings/Initializer/random_uniform:08
?
embedding_3/embeddings:0embedding_3/embeddings/Assign,embedding_3/embeddings/Read/ReadVariableOp:0(23embedding_3/embeddings/Initializer/random_uniform:08
x
dense/kernel:0dense/kernel/Assign"dense/kernel/Read/ReadVariableOp:0(2)dense/kernel/Initializer/random_uniform:08
g
dense/bias:0dense/bias/Assign dense/bias/Read/ReadVariableOp:0(2dense/bias/Initializer/zeros:08
?
dense_1/kernel:0dense_1/kernel/Assign$dense_1/kernel/Read/ReadVariableOp:0(2+dense_1/kernel/Initializer/random_uniform:08
o
dense_1/bias:0dense_1/bias/Assign"dense_1/bias/Read/ReadVariableOp:0(2 dense_1/bias/Initializer/zeros:08
?
dense_2/kernel:0dense_2/kernel/Assign$dense_2/kernel/Read/ReadVariableOp:0(2+dense_2/kernel/Initializer/random_uniform:08
o
dense_2/bias:0dense_2/bias/Assign"dense_2/bias/Read/ReadVariableOp:0(2 dense_2/bias/Initializer/zeros:08
|
rating/kernel:0rating/kernel/Assign#rating/kernel/Read/ReadVariableOp:0(2*rating/kernel/Initializer/random_uniform:08
k
rating/bias:0rating/bias/Assign!rating/bias/Read/ReadVariableOp:0(2rating/bias/Initializer/zeros:08"k
global_step\Z
X
global_step:0global_step/Assignglobal_step/read:02global_step/Initializer/zeros:0*?
serving_default?
%
item_id
Placeholder_1:0	?
#
user_id
Placeholder:0	?
item_id
Cast:0?)
rating
rating/BiasAdd:0	?tensorflow/serving/predict