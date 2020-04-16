from pygraphblas import *
from pygraphblas.base import _check, lib


def LAGraph_cc_fastsv(mx, sanitize=True):
    out = ffi.new('GrB_Vector*')
    _check(lib.LAGraph_cc_fastsv(
        out,
        mx.matrix[0],
        sanitize))

    return Vector(out)


def LAGraph_bfs_pushpull(A: Matrix, AT: Matrix, source: int, max_level: int = 0, vsparse: bool = False,
                         compute_parent: bool = False):
    """push-pull BFS, or push-only if AT = None

    :param A: input graph, treated as if boolean in semiring
    :param AT: transpose of A (optional; push-only if None)
    :param source: starting node of the BFS (s < 0: whole graph)
    :param max_level: optional limit of # levels to search
    :param vsparse: if true, v is expected to be very sparse
    :param compute_parent: if true, a second vector is returned which contains the parents of each node
    :return:
     (v, pi) pair if compute_parent is True, else v.
     Vector v: v(i) is the BFS level of node i in the graph.
     Vector pi: pi(i) is the parent of node i in the graph.
    """
    v_output = ffi.new('GrB_Vector*')
    pi_output = ffi.new('GrB_Vector*') if compute_parent \
        else NULL

    _check(lib.LAGraph_bfs_pushpull(
        v_output,
        pi_output,
        A.matrix[0] if A is not None else NULL,
        AT.matrix[0] if AT is not None else NULL,
        source,
        max_level,
        vsparse))

    if compute_parent:
        return Vector(v_output), Vector(pi_output)
    else:
        return Vector(v_output)
