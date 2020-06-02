import pytest

from pygraphblas import *
from pygraphblas.base import lib, _check
from pygraphblas.lagraph import LAGraph_bfs_pushpull


def test_bfs_pushpull():
    adj = Matrix.sparse(BOOL, 4, 4)
    adj[0, 1] = True
    adj[1, 2] = True

    print(adj)
    print(adj.to_string())

    level, parent = LAGraph_bfs_pushpull(adj, None, 0, compute_parent=True)

    print(level.to_string())
    print(parent.to_string())
