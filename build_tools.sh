
# Adapted from
# https://github.com/PrincetonUniversity/openpiton/blob/3cc7bf4d3d1ee2f8e18c33eda6c136a57222806b/piton/ariane_build_tools.sh#L83-L98

# parallel compilation
export NUM_JOBS=4

# # clean
# rm -rf $RISCV

# build scripts
cd $CVA6_ROOT
# ci/make-tmp.sh
# echo "finished ci/make-tmp.sh"
# ci/build-riscv-gcc.sh
# echo "finished ci/build-riscv-gcc.sh"
# ci/install-fesvr.sh
# echo "finished ci/install-fesvr.sh"
# ci/build-riscv-tests.sh
# echo "finished ci/build-riscv-tests.sh"
# ci/install-dtc.sh
# ci/install-spike.sh
# echo "finished ci/install-spike.sh"
# ci/get-torture.sh
ci/install-verilator.sh
echo "finished ci/install-verilator.sh"
