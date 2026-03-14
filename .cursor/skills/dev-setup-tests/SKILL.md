---
name: dev-setup-tests
description: Run and troubleshoot dev-setup test layers (Layer 1 e2e.sh, Layer 2 Bats, Layer 3 LXD/Docker E2E). Use when running tests, only Bats and LXD, or when LXD E2E is skipped with "lxc + driver lxd" or permission denied.
---

# dev-setup 测试

## 入口

统一入口（仓库根目录执行）：

```bash
./tests/run_tests.sh
```

可选环境变量控制是否跑 LXD/Docker E2E；不设则只跑 Layer 1（及 Layer 2 若已装 bats）。

## 只跑 Bats + LXD（不跑 Docker）

```bash
E2E_LXD=1 ./tests/run_tests.sh
```

- Layer 1（e2e.sh 快速测试）仍会执行。
- Layer 2：需已安装 `bats`（`npm i -g bats` 或 `apt install bats`）。
- Layer 3：只跑 LXD E2E，不跑 Docker。

## 若 LXD 被跳过："LXD not found or not usable (lxc + driver lxd), skip"

脚本通过 `lxc` 客户端且 `lxc info` 含 `driver: lxd` 判断 LXD 可用。跳过常见原因与处理：

1. **`lxc` 不在 PATH**  
   Snap 安装时客户端在 `/snap/bin`：
   ```bash
   export PATH="/snap/bin:$PATH"
   ```
   或在 `~/.zshrc` / `~/.bashrc` 中加入后重载。

2. **当前用户不在 `lxd` 组**  
   ```bash
   sudo usermod -aG lxd "$USER"
   ```
   然后**重新登录**或执行 `newgrp lxd`，再在同一 shell 中运行测试。

3. **在能执行 `lxc list` 的终端里跑测试**  
   IDE 内置终端若未继承 PATH 或 lxd 组，需在已配置好的终端中执行 `E2E_LXD=1 ./tests/run_tests.sh`。

## 环境变量速查

| 变量 | 作用 |
|------|------|
| `E2E_LXD=1` | 跑 LXD 最小 E2E（默认 ubuntu:22.04） |
| `E2E_LXD_FULL=1` | 再跑 LXD 多工具 E2E |
| `E2E_LXD_IMAGES` | 多镜像，如 `ubuntu:22.04 debian:12` |
| `E2E_DOCKER=1` | 跑 Docker 最小 E2E |
| `E2E_DOCKER_FULL=1` | 跑 Docker 多工具 E2E |

详见 `tests/README.md`。
