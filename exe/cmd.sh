#!/bin/bash
# arguments:
#   test_root_dir: absolute directory
#   result_file: file name
#   target_cmd: target command name
#   target_dir: relative directory from test_dir

function do_test()
{
   echo "##### ${target_cmd} $*  #####"
   $target_cmd $*
   ret_code=$?

   return $ret_code
}

# test_dir result_file target_cmd target_dir args
test_root_dir=$1
shift
result_file=$1
shift
target_cmd=$1
shift
target_dir=$1
shift
target_path="${test_root_dir}/${target_dir}"

if [ ! -d ${target_path} ];then
   mkdir -p ${target_path}
fi
result_path="${target_path}/${result_file}"
if [ ! -f ${result_path} ]; then
   touch ${result_path}
fi

pushd $target_path
do_test $*
ret=$?
#echo "ret=${ret}"

exit ${ret}
