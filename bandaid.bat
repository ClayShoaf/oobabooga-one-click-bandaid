@echo on

set INSTALL_ENV_DIR=%cd%\installer_files\env
set PATH=%INSTALL_ENV_DIR%;%INSTALL_ENV_DIR%\Library\bin;%INSTALL_ENV_DIR%\Scripts;%INSTALL_ENV_DIR%\Library\usr\bin;%PATH%
call conda activate
cd text-generation-webui
python -m pip install -r requirements.txt
mkdir repositories
cd repositories
git clone https://github.com/qwopqwop200/GPTQ-for-LLaMa
cd GPTQ-for-LLaMa
git reset --hard 468c47c01b4fe370616747b6d69a2d3f48bab5e4

cd ..\..\..

echo AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

curl -LO https://github.com/DeXtmL/bitsandbytes-win-prebuilt/raw/main/libbitsandbytes_cpu.dll
curl -LO https://github.com/DeXtmL/bitsandbytes-win-prebuilt/raw/main/libbitsandbytes_cuda116.dll
mv libbitsandbytes_cpu.dll installer_files\env\lib\site-packages\bitsandbytes\
mv libbitsandbytes_cuda116.dll installer_files\env\lib\site-packages\bitsandbytes\

echo BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB

pip install sed
sed -i 's/if not torch.cuda.is_available(): return \'libsbitsandbytes_cpu.so\', None, None, None, None/if torch.cuda.is_available(): return \'libbitsandbytes_cuda116.dll\', None, None, None, None/g' installer_files\env\lib\site-packages\bitsandbytes\cuda_setup\main.py
sed -i 's/ct.cdll.LoadLibrary(binary_path)/ct.cdll.LoadLibrary(str(binary_path))/g' installer_files\env\lib\site-packages\bitsandbytes\cuda_setup\main.py

echo CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

pip install unzip
curl -LO https://github.com/oobabooga/text-generation-webui/files/10947842/quant_cuda-0.0.0-cp310-cp310-win_amd64.whl.zip
unzip quant_cuda-0.0.0-cp310-cp310-win_amd64.whl.zip
pip install quant_cuda-0.0.0-cp310-cp310-win_amd64.whl

echo DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD

call conda install -y -c conda-forge cudatoolkit-dev

echo WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW

call conda install -y pytorch torchvision torchaudio pytorch-cuda=11.7 cuda-toolkit -c "nvidia/label/cuda-11.7.0" -c pytorch -c nvidia

echo EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

sed -i 's/call python server.py --auto-devices --cai-chat/call python server.py --auto-devices --cai-chat --gptq-bits 4 --gptq-model-type LLaMa/g' start-webui.bat

echo FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

install.bat

pause
