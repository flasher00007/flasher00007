#!/data/data/com.termux/files/usr/bin/bash

# Function to add delay after each command
delay() {
    sleep 2  # 2-second delay, adjust as needed
}

# Update system and install dependencies
echo "[*] Updating system and installing dependencies..."
apt update -y && apt upgrade -y
delay

echo "[*] Installing required dependencies..."
apt install git wget proot cmake build-essential libuv-dev libssl-dev libhwloc-dev -y
delay

# Create xmrig directory if it doesn't exist
echo "[*] Creating xmrig directory..."
mkdir -p $HOME/xmrig
delay
cd $HOME/xmrig

# Clone the XMRig repository
echo "[*] Cloning XMRig from GitHub..."
git clone https://github.com/xmrig/xmrig.git
delay
cd xmrig

# Create the build directory
echo "[*] Creating build directory..."
mkdir build && cd build
delay

# Run cmake config inside the build folder
echo "[*] Configuring XMRig..."
cmake -DWITH_HWLOC=OFF ..
delay

# Compile XMRig
echo "[*] Compiling XMRig (this may take some time)..."
make -j$(nproc)
delay

# Make xmrig executable if not already
echo "[*] Making xmrig executable..."
chmod +x ../xmrig
delay

# Create the mining start script
echo "[*] Creating mining start script..."
cat <<EOF > start.sh
#!/data/data/com.termux/files/usr/bin/bash
./xmrig -o rx-asia.unmineable.com:443 -a rx -k --tls -u BTC:bc1qx5slrgyp6n2wmqftzpt22jgenwhtsfpm39r0zq.Miner001
EOF
delay

# Make start script executable
echo "[*] Making start script executable..."
chmod +x start.sh
delay

# Start mining
echo "[*] Starting XMRig miner..."
./start.sh

