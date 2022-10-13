#! /bin/bash
##  Database Foundation and Practice Course , DaSE of ECNU
##  Only for learning and communication, rigorous for business behavior
##  all copyright @Heyuan.Hu from DaSE

if [ -d "./db_impl_course" ];
then
    echo "./db_impl_course dircition is exist , remove it!"
    rm -rf ./db_impl_course
fi


cpus=$(cat /proc/cpuinfo | grep processor | wc -l)
echo "cpu cores num: $cpus"

PROJ_FATHER_DIR=$(cd $(dirname $0);pwd)
git clone  https://gitlab.com/paperybox/db_impl_course_backup/ db_impl_course
PROJ_DIR="$PROJ_FATHER_DIR/db_impl_course"
echo "cd $PROJ_DIR"
cd $PROJ_DIR

git checkout Heyuan.Hu
git pull origin Heyuan.Hu

git submodule add https://gitee.com/zhouhuahui/libevent deps/libevent
cd deps
cd libevent
git checkout release-2.1.12-stable
mkdir build
cd build
cmake .. -DEVENT__DISABLE_OPENSSL=ON
make -j$cpus
sudo make install

cd $PROJ_DIR
git submodule add  https://gitee.com/zhouhuahui/googletest deps/googletest
cd deps
cd googletest
mkdir build
cd build
cmake ..
make -j$cpus
sudo make install

cd $PROJ_DIR
git submodule add  https://gitee.com/zhouhuahui/jsoncpp.git deps/jsoncpp
cd ./deps
cd ./jsoncpp
mkdir build
cd ./build
cmake -DJSONCPP_WITH_TESTS=OFF -DJSONCPP_WITH_POST_BUILD_UNITTEST=OFF ..
make -j$cpus
sudo make install

cd $PROJ_DIR
mkdir build
cd build
cmake ..
make -j$cpus

cd $PROJ_DIR
if [ -e "./build/bin/bitmap_test" ];
then
    echo "enjoy!"
else
    echo "something is wrong,please check!"
fi
