
# Adapted from
# https://github.com/PrincetonUniversity/openpiton/blob/3cc7bf4d3d1ee2f8e18c33eda6c136a57222806b/piton/ariane_setup.sh

# tool install directory
export RISCV=`pwd`/tools

# init cva6 submodule
git submodule update --init --recursive

# PATHS
export CVA6_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/cva6" && pwd)
export PATH=$RISCV/bin:/bin:$PATH
export LIBRARY_PATH=$RISCV/lib
export LD_LIBRARY_PATH=$RISCV/lib
export C_INCLUDE_PATH=$RISCV/include
export CPLUS_INCLUDE_PATH=$RISCV/include
