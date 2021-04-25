图环
===========

图分为有向图（directed graph，digraph）和无向图（undirected graph），区别在于节点之间的边是否有方向。

**问题** ：检测连通图中是否有环。


无向图
-----------

- **深度优先遍历** （depth first search traversal）

  标记法，使用 visited 数组对图中的所有顶点定义三种状态：

    - 顶点未被访问过（0）

    - 顶点刚开始被访问（1）

    - 顶点被访问过，并且其所有邻接点也被访问过（2）

  另外，使用 father 数组记录 DFS 过程中所有顶点的父节点。

  判断：若在 DFS 过程中遇到“回边”（即指向已经访问过的顶点的边，父节点除外），则存在环。

  .. code-block:: cpp
    :linenos:

    void DFS(int v, Graph G)
    {
        visited[v] = 1; // 开始访问节点 v
        for(int i = 0 ; i < G.vertexNum; i++)
        {
            if(i != v && G.arc[v][i] != INF) // 邻接矩阵中节点 v 的邻接点（邻接矩阵表示法）
            {
                if(visited[i] == 1 && father[v] != i)
                // i 不是父节点，而且还被访问过（状态 1，说明不是回溯过来的顶点），说明存在环
                // visited[i] == 2 不行：
                // 对无向图而言，v 也是 i 的邻接点，意味着 i -> v 早就访问过，不会再重复访问 v -> i，因此不会出现 visited[i] == 2
                // 对有向图而言，说明 i 是 v 和其他节点的公共子节点，不构成环
                {
                    cout<<"图存在环";
                    int temp = v;
                    while(temp != i)
                    {
                        cout<< temp << " <- "; // 输出环
                        temp = father[temp];
                    }
                    cout<< i <<endl;
                }
                else
                    if(visited[i] == 0)
                    {
                        father[i] = v; // 更新 father 数组
                        DFS(i, G);
                    }

            }
        }
        visited[v] = 2; // 遍历完 v 所有的邻接点，变为状态 2
    }


- **广度优先遍历** （breadth first search traversal）

  与 DFS 类似，需要使用 father 数组记录 BFS 过程中所有顶点的父节点。

  visited 数组只需要记录两种状态：未访问和已访问。


有向图
-----------

- **拓扑排序** （topological sorting）

  见本章第 10 节。

- **深度优先遍历** （depth first search traversal）

  与无向图的 DFS 相同。


参考资料
----------

1. 判断无向图/有向图中是否存在环

  https://www.cnblogs.com/wangkundentisy/p/9320499.html
