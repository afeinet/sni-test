#!/bin/bash

# 清屏，让粉丝的终端界面干净好看
clear

# 输出你的专属频道 Banner
echo -e "\n\033[1;36m=========================================\n       🚀 youtube.com/@afeinet 🚀\n=========================================\033[0m\n"
echo -e "正在为您检测最适合当前 VPS 节点的 3x-ui Reality 伪装网站...\n"

# 域名列表（去除了国内被墙的，保留了全球顶级大厂 CDN 域名）
domains=(
    "azure.microsoft.com" "bing.com" "www.icloud.com" "statici.icloud.com" 
    "www.microsoft.com" "xp.apple.com" "vs.aws.amazon.com" "www.xbox.com" 
    "www.oracle.com" "images.nvidia.com" "www.amazon.com" "aws.amazon.com" 
    "www.amd.com" "www.sony.com" "www.tesla.com" "www.intel.com" 
    "www.nvidia.com" "www.apple.com"
)

# 循环测试延迟（极速并发模式，单个网站硬性死等 1.5 秒）
for d in "${domains[@]}"; do
    (
        r=$(curl -s -o /dev/null -m 1.5 -w "%{time_appconnect}" "https://$d")
        awk -v d="$d" -v r="$r" 'BEGIN {
            if (r>0) 
                printf "%-24s : \033[1;32m%.0f ms\033[0m\n", d, r*1000; 
            else 
                printf "%-24s : \033[1;31mtimeout\033[0m\n", d
        }'
    ) &
done

# 等待所有后台测试任务安全完成
wait
echo -e "\n\033[1;36m=========================================\033[0m"
echo -e "检测完成！请选择绿色且延迟较低的域名写入 3x-ui。\n"
