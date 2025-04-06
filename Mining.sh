#!/data/data/com.termux/files/usr/bin/bash

echo "[*] Updating and installing dependencies..."
apt update -y
apt upgrade -y

echo "[*] Installing basic dependencies..."
apt install git wget proot cmake build-essential -y

echo "[*] Installing libuv (Termux package)..."
pkg install libuv -y

echo "[*] Installing hwloc (Termux package)..."
pkg install hwloc -y

echo "[*] Installing OpenSSL (libssl alternative)..."
pkg install libssl -y

echo "[*] Cloning XMRig repository..."
git clone https://github.com/xmrig/xmrig.git
cd xmrig

echo "[*] Creating build directory..."
mkdir build && cd build

echo "[*] Configuring build with CMake..."
cmake -DWITH_HWLOC=OFF ..

echo "[*] Compiling XMRig..."
make -j$(nproc)

echo "[*] Creating start script..."
cat <<EOF > start.sh
#!/data/data/com.termux/files/usr/bin/bash
./xmrig -o rx-asia.unmineable.com:443 -a rx -k --tls -u BTC:bc1qx5slrgyp6n2wmqftzpt22jgenwhtsfpm39r0zq.Miner001
EOF

chmod +x start.sh

echo "[*] Starting miner in background..."
nohup ./start.sh > xmrig.log 2>&1 &
