#!/bin/bash
# arguments:
#   test_root_dir: absolute directory
#   result_file: file name
#   target_cmd: target command name
#   target_dir: relative directory from test_dir

function do_test()
{
   target_cmd=$1
   shift
   pushd $1
   shift
   echo "##### ${target_cmd} $*  #####"
   $target_cmd $*
   exit_code=$?
   popd

   return $exit_code
}

# test_dir result_file target_cmd target_dir args
# bash /home/ykominami/repo/clitest/bin/cmd.sh 
# /home/ykominami/repo/clitest/spec/test cmd1 ls  result.txt
#echo $*
test_root_dir=$1
shift
result_file=$1
shift
target_dir=$2
target_path=${test_root_dir}/${target_dir}
if [ ! -d ${target_path} ];then
   mkdir -p ${target_path}
fi
result_path="${target_path}/${result_file}"
# echo "result_path=${result_path}"
if [ ! -f ${result_path} ]; then
   touch ${result_path}
fi

do_test $* | tee $result_path
exit $?
