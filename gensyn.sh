#!/bin/bash

echo "📥 Cloning Official Gensyn RL Swarm..."
cd $HOME
rm -rf rl-swarm
git clone https://github.com/gensyn-ai/rl-swarm.git
cd rl-swarm

echo "🧪 Creating virtual environment..."
python3 -m venv .venv
source .venv/bin/activate

echo "📚 Installing Python dependencies (CPU only)..."
pip install -r requirements-cpu.txt

echo "🚀 Launching Gensyn node..."
chmod +x run_rl_swarm.sh
./run_rl_swarm.sh
