??
??
:
Add
x"T
y"T
z"T"
Ttype:
2	
?
ArgMax

input"T
	dimension"Tidx
output"output_type" 
Ttype:
2	"
Tidxtype0:
2	"
output_typetype0	:
2	
x
Assign
ref"T?

value"T

output_ref"T?"	
Ttype"
validate_shapebool("
use_lockingbool(?
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
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
W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
?
GatherV2
params"Tparams
indices"Tindices
axis"Taxis
output"Tparams"
Tparamstype"
Tindicestype:
2	"
Taxistype:
2	
?
HashTableV2
table_handle"
	containerstring "
shared_namestring "!
use_node_name_sharingbool( "
	key_dtypetype"
value_dtypetype?
.
Identity

input"T
output"T"	
Ttype
?
InitializeTableFromTextFileV2
table_handle
filename"
	key_indexint(0?????????"
value_indexint(0?????????"+

vocab_sizeint?????????(0?????????"
	delimiterstring	?
w
LookupTableFindV2
table_handle
keys"Tin
default_value"Tout
values"Tout"
Tintype"
Touttype?
2
LookupTableSizeV2
table_handle
size	?
p
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:
	2
?
Mean

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
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
E
NotEqual
x"T
y"T
z
"
Ttype:
2	
?
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
?
ParseExample

serialized	
names
sparse_keys*Nsparse

dense_keys*Ndense
dense_defaults2Tdense
sparse_indices	*Nsparse
sparse_values2sparse_types
sparse_shapes	*Nsparse
dense_values2Tdense"
Nsparseint("
Ndenseint("%
sparse_types
list(type)(:
2	"
Tdense
list(type)(:
2	"
dense_shapeslist(shape)(
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
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
9
Softmax
logits"T
softmax"T"
Ttype:
2
?
SparseToDense
sparse_indices"Tindices
output_shape"Tindices
sparse_values"T
default_value"T

dense"T"
validate_indicesbool("	
Ttype"
Tindicestype:
2	
?
StridedSlice

input"T
begin"Index
end"Index
strides"Index
output"T"	
Ttype"
Indextype:
2	"

begin_maskint "
end_maskint "
ellipsis_maskint "
new_axis_maskint "
shrink_axis_maskint 
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
K
StringToHashBucket
string_tensor

output	"
num_bucketsint(0
G
StringToHashBucketFast	
input

output	"
num_bucketsint(0
:
Sub
x"T
y"T
z"T"
Ttype:
2	
s

VariableV2
ref"dtype?"
shapeshape"
dtypetype"
	containerstring "
shared_namestring ?"serve*1.10.02v1.10.0-0-g656e7a2b34?y

global_step/Initializer/zerosConst*
_class
loc:@global_step*
value	B	 R *
dtype0	*
_output_shapes
: 
?
global_step
VariableV2*
	container *
shape: *
dtype0	*
_output_shapes
: *
shared_name *
_class
loc:@global_step
?
global_step/AssignAssignglobal_stepglobal_step/Initializer/zeros*
T0	*
_class
loc:@global_step*
validate_shape(*
_output_shapes
: *
use_locking(
j
global_step/readIdentityglobal_step*
T0	*
_class
loc:@global_step*
_output_shapes
: 
o
input_example_tensorPlaceholder*
shape:?????????*
dtype0*#
_output_shapes
:?????????
b
ParseExample/ParseExample/namesConst*
valueB *
dtype0*
_output_shapes
: 
n
'ParseExample/ParseExample/sparse_keys_0Const*
valueB Bngrams*
dtype0*
_output_shapes
: 
l
'ParseExample/ParseExample/sparse_keys_1Const*
valueB
 Btext*
dtype0*
_output_shapes
: 
?
ParseExample/ParseExampleParseExampleinput_example_tensorParseExample/ParseExample/names'ParseExample/ParseExample/sparse_keys_0'ParseExample/ParseExample/sparse_keys_1*
Tdense
 *
Ndense *d
_output_shapesR
P:?????????:?????????:?????????:?????????::*
Nsparse*
sparse_types
2*
dense_shapes
 
]
SparseToDense/default_valueConst*
value	B B *
dtype0*
_output_shapes
: 
?
SparseToDenseSparseToDenseParseExample/ParseExample:1ParseExample/ParseExample:5ParseExample/ParseExample:3SparseToDense/default_value*
Tindices0	*
validate_indices(*
T0*0
_output_shapes
:??????????????????
_
SparseToDense_1/default_valueConst*
value	B B *
dtype0*
_output_shapes
: 
?
SparseToDense_1SparseToDenseParseExample/ParseExampleParseExample/ParseExample:4ParseExample/ParseExample:2SparseToDense_1/default_value*0
_output_shapes
:??????????????????*
Tindices0	*
validate_indices(*
T0
?
string_to_index/hash_tableHashTableV2*
value_dtype0	*
_output_shapes
: *;
shared_name,*hash_table_./train.txt.vocab_3194148_-2_-1*
use_node_name_sharing( *
	key_dtype0*
	container 
k
 string_to_index/hash_table/ConstConst*
valueB	 R
?????????*
dtype0	*
_output_shapes
: 
?
4string_to_index/hash_table/table_init/asset_filepathConst*"
valueB B./train.txt.vocab*
dtype0*
_output_shapes
: 
?
%string_to_index/hash_table/table_initInitializeTableFromTextFileV2string_to_index/hash_table4string_to_index/hash_table/table_init/asset_filepath*
	key_index?????????*
value_index?????????*

vocab_size???*
	delimiter	
?
"string_to_index_Lookup/hash_bucketStringToHashBucketFastSparseToDense*0
_output_shapes
:??????????????????*
num_buckets
?
(string_to_index_Lookup/hash_table_LookupLookupTableFindV2string_to_index/hash_tableSparseToDense string_to_index/hash_table/Const*0
_output_shapes
:??????????????????*	
Tin0*

Tout0	
o
&string_to_index_Lookup/hash_table_SizeLookupTableSizeV2string_to_index/hash_table*
_output_shapes
: 
?
string_to_index_Lookup/AddAdd"string_to_index_Lookup/hash_bucket&string_to_index_Lookup/hash_table_Size*
T0	*0
_output_shapes
:??????????????????
?
string_to_index_Lookup/NotEqualNotEqual(string_to_index_Lookup/hash_table_Lookup string_to_index/hash_table/Const*0
_output_shapes
:??????????????????*
T0	
?
string_to_index_LookupSelectstring_to_index_Lookup/NotEqual(string_to_index_Lookup/hash_table_Lookupstring_to_index_Lookup/Add*
T0	*0
_output_shapes
:??????????????????
e
random_uniform/shapeConst*
valueB"8?0    *
dtype0*
_output_shapes
:
W
random_uniform/minConst*
valueB
 *??̽*
dtype0*
_output_shapes
: 
W
random_uniform/maxConst*
dtype0*
_output_shapes
: *
valueB
 *???=
?
random_uniform/RandomUniformRandomUniformrandom_uniform/shape*
T0*
dtype0*!
_output_shapes
:???*
seed2 *

seed 
b
random_uniform/subSubrandom_uniform/maxrandom_uniform/min*
T0*
_output_shapes
: 
w
random_uniform/mulMulrandom_uniform/RandomUniformrandom_uniform/sub*!
_output_shapes
:???*
T0
i
random_uniformAddrandom_uniform/mulrandom_uniform/min*
T0*!
_output_shapes
:???
?
Variable
VariableV2*
shape:???*
shared_name *
dtype0*!
_output_shapes
:???*
	container 
?
Variable/AssignAssignVariablerandom_uniform*
T0*
_class
loc:@Variable*
validate_shape(*!
_output_shapes
:???*
use_locking(
l
Variable/readIdentityVariable*
T0*
_class
loc:@Variable*!
_output_shapes
:???
t
embedding_lookup/axisConst*
_class
loc:@Variable*
value	B : *
dtype0*
_output_shapes
: 
?
embedding_lookupGatherV2Variable/readstring_to_index_Lookupembedding_lookup/axis*
Tparams0*
_class
loc:@Variable*4
_output_shapes"
 :??????????????????*
Taxis0*
Tindices0	
X
Mean/reduction_indicesConst*
value	B :*
dtype0*
_output_shapes
: 
?
MeanMeanembedding_lookupMean/reduction_indices*'
_output_shapes
:?????????*
	keep_dims( *

Tidx0*
T0
?
StringToHashBucketStringToHashBucketSparseToDense_1*0
_output_shapes
:??????????????????*
num_buckets??
g
random_uniform_1/shapeConst*
valueB"??    *
dtype0*
_output_shapes
:
Y
random_uniform_1/minConst*
valueB
 *??̽*
dtype0*
_output_shapes
: 
Y
random_uniform_1/maxConst*
dtype0*
_output_shapes
: *
valueB
 *???=
?
random_uniform_1/RandomUniformRandomUniformrandom_uniform_1/shape*
T0*
dtype0* 
_output_shapes
:
??*
seed2 *

seed 
h
random_uniform_1/subSubrandom_uniform_1/maxrandom_uniform_1/min*
T0*
_output_shapes
: 
|
random_uniform_1/mulMulrandom_uniform_1/RandomUniformrandom_uniform_1/sub*
T0* 
_output_shapes
:
??
n
random_uniform_1Addrandom_uniform_1/mulrandom_uniform_1/min* 
_output_shapes
:
??*
T0
?

Variable_1
VariableV2*
dtype0* 
_output_shapes
:
??*
	container *
shape:
??*
shared_name 
?
Variable_1/AssignAssign
Variable_1random_uniform_1*
validate_shape(* 
_output_shapes
:
??*
use_locking(*
T0*
_class
loc:@Variable_1
q
Variable_1/readIdentity
Variable_1*
T0*
_class
loc:@Variable_1* 
_output_shapes
:
??
x
embedding_lookup_1/axisConst*
_class
loc:@Variable_1*
value	B : *
dtype0*
_output_shapes
: 
?
embedding_lookup_1GatherV2Variable_1/readStringToHashBucketembedding_lookup_1/axis*
Taxis0*
Tindices0	*
Tparams0*
_class
loc:@Variable_1*4
_output_shapes"
 :??????????????????
Z
Mean_1/reduction_indicesConst*
value	B :*
dtype0*
_output_shapes
: 
?
Mean_1Meanembedding_lookup_1Mean_1/reduction_indices*
	keep_dims( *

Tidx0*
T0*'
_output_shapes
:?????????
P
ExpandDims/dimConst*
dtype0*
_output_shapes
: *
value	B :
r

ExpandDims
ExpandDimsMean_1ExpandDims/dim*+
_output_shapes
:?????????*

Tdim0*
T0
h
strided_slice/stackConst*!
valueB"            *
dtype0*
_output_shapes
:
j
strided_slice/stack_1Const*!
valueB"           *
dtype0*
_output_shapes
:
j
strided_slice/stack_2Const*!
valueB"         *
dtype0*
_output_shapes
:
?
strided_sliceStridedSlice
ExpandDimsstrided_slice/stackstrided_slice/stack_1strided_slice/stack_2*
shrink_axis_mask*
ellipsis_mask *

begin_mask*
new_axis_mask *
end_mask*'
_output_shapes
:?????????*
Index0*
T0
V
concat/axisConst*
dtype0*
_output_shapes
: *
valueB :
?????????
{
concatConcatV2Meanstrided_sliceconcat/axis*
T0*
N*'
_output_shapes
:????????? *

Tidx0
?
8fully_connected/weights/Initializer/random_uniform/shapeConst**
_class 
loc:@fully_connected/weights*
valueB"    Z  *
dtype0*
_output_shapes
:
?
6fully_connected/weights/Initializer/random_uniform/minConst*
dtype0*
_output_shapes
: **
_class 
loc:@fully_connected/weights*
valueB
 *
?
?
6fully_connected/weights/Initializer/random_uniform/maxConst**
_class 
loc:@fully_connected/weights*
valueB
 *
>*
dtype0*
_output_shapes
: 
?
@fully_connected/weights/Initializer/random_uniform/RandomUniformRandomUniform8fully_connected/weights/Initializer/random_uniform/shape*
T0**
_class 
loc:@fully_connected/weights*
seed2 *
dtype0*
_output_shapes
:	 ?*

seed 
?
6fully_connected/weights/Initializer/random_uniform/subSub6fully_connected/weights/Initializer/random_uniform/max6fully_connected/weights/Initializer/random_uniform/min*
T0**
_class 
loc:@fully_connected/weights*
_output_shapes
: 
?
6fully_connected/weights/Initializer/random_uniform/mulMul@fully_connected/weights/Initializer/random_uniform/RandomUniform6fully_connected/weights/Initializer/random_uniform/sub*
T0**
_class 
loc:@fully_connected/weights*
_output_shapes
:	 ?
?
2fully_connected/weights/Initializer/random_uniformAdd6fully_connected/weights/Initializer/random_uniform/mul6fully_connected/weights/Initializer/random_uniform/min*
_output_shapes
:	 ?*
T0**
_class 
loc:@fully_connected/weights
?
fully_connected/weights
VariableV2*
shared_name **
_class 
loc:@fully_connected/weights*
	container *
shape:	 ?*
dtype0*
_output_shapes
:	 ?
?
fully_connected/weights/AssignAssignfully_connected/weights2fully_connected/weights/Initializer/random_uniform*
use_locking(*
T0**
_class 
loc:@fully_connected/weights*
validate_shape(*
_output_shapes
:	 ?
?
fully_connected/weights/readIdentityfully_connected/weights*
T0**
_class 
loc:@fully_connected/weights*
_output_shapes
:	 ?
?
(fully_connected/biases/Initializer/zerosConst*)
_class
loc:@fully_connected/biases*
valueB?*    *
dtype0*
_output_shapes	
:?
?
fully_connected/biases
VariableV2*
shared_name *)
_class
loc:@fully_connected/biases*
	container *
shape:?*
dtype0*
_output_shapes	
:?
?
fully_connected/biases/AssignAssignfully_connected/biases(fully_connected/biases/Initializer/zeros*
validate_shape(*
_output_shapes	
:?*
use_locking(*
T0*)
_class
loc:@fully_connected/biases
?
fully_connected/biases/readIdentityfully_connected/biases*
T0*)
_class
loc:@fully_connected/biases*
_output_shapes	
:?
?
fully_connected/MatMulMatMulconcatfully_connected/weights/read*
transpose_b( *
T0*(
_output_shapes
:??????????*
transpose_a( 
?
fully_connected/BiasAddBiasAddfully_connected/MatMulfully_connected/biases/read*
data_formatNHWC*(
_output_shapes
:??????????*
T0
[
ArgMax/dimensionConst*
valueB :
?????????*
dtype0*
_output_shapes
: 
?
ArgMaxArgMaxfully_connected/BiasAddArgMax/dimension*
T0*
output_type0	*#
_output_shapes
:?????????*

Tidx0
^
SoftmaxSoftmaxfully_connected/BiasAdd*
T0*(
_output_shapes
:??????????

initNoOp
?
init_all_tablesNoOp&^string_to_index/hash_table/table_init

init_1NoOp
4

group_depsNoOp^init^init_1^init_all_tables
P

save/ConstConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
?
save/StringJoin/inputs_1Const*
dtype0*
_output_shapes
: *<
value3B1 B+_temp_88b13f44a2754020bc5057758cc9a05a/part
u
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
	separator *
N*
_output_shapes
: 
Q
save/num_shardsConst*
dtype0*
_output_shapes
: *
value	B :
k
save/ShardedFilename/shardConst"/device:CPU:0*
value	B : *
dtype0*
_output_shapes
: 
?
save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards"/device:CPU:0*
_output_shapes
: 
?
save/SaveV2/tensor_namesConst"/device:CPU:0*g
value^B\BVariableB
Variable_1Bfully_connected/biasesBfully_connected/weightsBglobal_step*
dtype0*
_output_shapes
:
|
save/SaveV2/shape_and_slicesConst"/device:CPU:0*
dtype0*
_output_shapes
:*
valueBB B B B B 
?
save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesVariable
Variable_1fully_connected/biasesfully_connected/weightsglobal_step"/device:CPU:0*
dtypes	
2	
?
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2"/device:CPU:0*
T0*'
_class
loc:@save/ShardedFilename*
_output_shapes
: 
?
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency"/device:CPU:0*
T0*

axis *
N*
_output_shapes
:
?
save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const"/device:CPU:0*
delete_old_dirs(
?
save/IdentityIdentity
save/Const^save/MergeV2Checkpoints^save/control_dependency"/device:CPU:0*
_output_shapes
: *
T0
?
save/RestoreV2/tensor_namesConst"/device:CPU:0*
dtype0*
_output_shapes
:*g
value^B\BVariableB
Variable_1Bfully_connected/biasesBfully_connected/weightsBglobal_step

save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
valueBB B B B B *
dtype0*
_output_shapes
:
?
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*(
_output_shapes
:::::*
dtypes	
2	
?
save/AssignAssignVariablesave/RestoreV2*
validate_shape(*!
_output_shapes
:???*
use_locking(*
T0*
_class
loc:@Variable
?
save/Assign_1Assign
Variable_1save/RestoreV2:1*
T0*
_class
loc:@Variable_1*
validate_shape(* 
_output_shapes
:
??*
use_locking(
?
save/Assign_2Assignfully_connected/biasessave/RestoreV2:2*
use_locking(*
T0*)
_class
loc:@fully_connected/biases*
validate_shape(*
_output_shapes	
:?
?
save/Assign_3Assignfully_connected/weightssave/RestoreV2:3*
use_locking(*
T0**
_class 
loc:@fully_connected/weights*
validate_shape(*
_output_shapes
:	 ?
?
save/Assign_4Assignglobal_stepsave/RestoreV2:4*
use_locking(*
T0	*
_class
loc:@global_step*
validate_shape(*
_output_shapes
: 
h
save/restore_shardNoOp^save/Assign^save/Assign_1^save/Assign_2^save/Assign_3^save/Assign_4
-
save/restore_allNoOp^save/restore_shard"<
save/Const:0save/Identity:0save/restore_all (5 @F8"k
global_step\Z
X
global_step:0global_step/Assignglobal_step/read:02global_step/Initializer/zeros:0"?
saved_model_assets~*|
z
+type.googleapis.com/tensorflow.AssetFileDefK
8
6string_to_index/hash_table/table_init/asset_filepath:0train.txt.vocab"?
model_variables??
?
fully_connected/weights:0fully_connected/weights/Assignfully_connected/weights/read:024fully_connected/weights/Initializer/random_uniform:08
?
fully_connected/biases:0fully_connected/biases/Assignfully_connected/biases/read:02*fully_connected/biases/Initializer/zeros:08"?
trainable_variables??
B

Variable:0Variable/AssignVariable/read:02random_uniform:08
J
Variable_1:0Variable_1/AssignVariable_1/read:02random_uniform_1:08
?
fully_connected/weights:0fully_connected/weights/Assignfully_connected/weights/read:024fully_connected/weights/Initializer/random_uniform:08
?
fully_connected/biases:0fully_connected/biases/Assignfully_connected/biases/read:02*fully_connected/biases/Initializer/zeros:08"?
	variables??
X
global_step:0global_step/Assignglobal_step/read:02global_step/Initializer/zeros:0
B

Variable:0Variable/AssignVariable/read:02random_uniform:08
J
Variable_1:0Variable_1/AssignVariable_1/read:02random_uniform_1:08
?
fully_connected/weights:0fully_connected/weights/Assignfully_connected/weights/read:024fully_connected/weights/Initializer/random_uniform:08
?
fully_connected/biases:0fully_connected/biases/Assignfully_connected/biases/read:02*fully_connected/biases/Initializer/zeros:08" 
legacy_init_op


group_deps">
table_initializer)
'
%string_to_index/hash_table/table_init"M
asset_filepaths:
8
6string_to_index/hash_table/table_init/asset_filepath:0*?
serving_default
3
inputs)
input_example_tensor:0?????????+
scores!
	Softmax:0??????????tensorflow/serving/classify*?
proba
3
inputs)
input_example_tensor:0?????????+
scores!
	Softmax:0??????????tensorflow/serving/classify*?
	embedding{
3
inputs)
input_example_tensor:0?????????(
outputs
Mean:0?????????tensorflow/serving/regress