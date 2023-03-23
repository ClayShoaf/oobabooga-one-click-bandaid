# oobabooga-one-click-bandaid
A simple batch file to make the oobabooga one click installer compatible with llama 4bit models and able to run on cuda
1. download and extract the windows zip file from here: https://github.com/oobabooga/text-generation-webui/releases
2. place `bandaid.bat` in the same folder as `install.bat`
3. double click `install.bat` and let it run all the way through
4. double click `bandaid.bat` and let it run all the way through (it will run install.bat again to fix some stuff that this hacky jank messes up. Don't worry, everything that's running is running from within the oobabooga folder. Worst case scenario, you delete everything and start from scratch)
5. place your models in the `text-generation-webui\models` folder. The folder structure should look like this
```
models\
 |
 |- model-name-4bit.pt
 |- model-name\
     |- config.json
     |- generation_config.json
     |- pytorch_model.bin.index.json
     |- special_tokens_map.json
     |- tokenizer.model
     |- tokenizer_config.json
```

6. make sure tokenizer_config.json says `"tokenizer_class": "LlamaTokenizer"` and not `"tokenizer_class": "LLaMATokenizer"`
7. double click on `start-webui.bat`

If you are still getting cuda errors, you are on your own. This is what worked for me. Good luck!

Credit: I just slapped this .bat file together. Most of the hard work was done by the users in this thread: https://github.com/qwopqwop200/GPTQ-for-LLaMa/issues/11#issuecomment-1464958666
