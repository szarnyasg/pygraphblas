from pygraphblas import *
from pygraphblas.base import _check, lib


def LAGraph_cc_fastsv(mx, sanitize=True):
    out = ffi.new('GrB_Vector*')
    _check(lib.LAGraph_cc_fastsv(
        out,
        mx.matrix[0],
        sanitize))

    return Vector(out)
