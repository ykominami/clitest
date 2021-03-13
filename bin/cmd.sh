#!/bin/bash
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
echo $*
test_dir=$1
shift
result_file=$1
shift
target_dir=$2
if [ ! -e $target_dir ];then
   mkdir ${target_dir}
fi
result_path="${test_dir}/${target_dir}/${result_file}"
# echo "result_path=${result_path}"
if [ ! -f ${result_path} ]; then
   touch ${result_path}
fi

do_test $* | tee $result_path
exit $?
