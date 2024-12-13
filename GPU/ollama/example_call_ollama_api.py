#!/usr/bin/env python3
#  ██████╗ ██╗     ██╗      █████╗ ███╗   ███╗ █████╗                     
# ██╔═══██╗██║     ██║     ██╔══██╗████╗ ████║██╔══██╗                    
# ██║   ██║██║     ██║     ███████║██╔████╔██║███████║                    
# ██║   ██║██║     ██║     ██╔══██║██║╚██╔╝██║██╔══██║                    
# ╚██████╔╝███████╗███████╗██║  ██║██║ ╚═╝ ██║██║  ██║                    
#  ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝                    
                                                                        
# ██╗      █████╗ ███╗   ██╗ ██████╗  ██████╗██╗  ██╗ █████╗ ██╗███╗   ██╗
# ██║     ██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║  ██║██╔══██╗██║████╗  ██║
# ██║     ███████║██╔██╗ ██║██║  ███╗██║     ███████║███████║██║██╔██╗ ██║
# ██║     ██╔══██║██║╚██╗██║██║   ██║██║     ██╔══██║██╔══██║██║██║╚██╗██║
# ███████╗██║  ██║██║ ╚████║╚██████╔╝╚██████╗██║  ██║██║  ██║██║██║ ╚████║
# ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝
                                                                        
# ███████╗██╗  ██╗ █████╗ ███╗   ███╗██████╗ ██╗     ███████╗             
# ██╔════╝╚██╗██╔╝██╔══██╗████╗ ████║██╔══██╗██║     ██╔════╝             
# █████╗   ╚███╔╝ ███████║██╔████╔██║██████╔╝██║     █████╗               
# ██╔══╝   ██╔██╗ ██╔══██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══╝               
# ███████╗██╔╝ ██╗██║  ██║██║ ╚═╝ ██║██║     ███████╗███████╗             
# ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝     ╚══════╝╚══════╝             
                                                                        
import os
from langchain_core.prompts import ChatPromptTemplate
from langchain_ollama.llms import OllamaLLM

PORT_FILE = os.path.expanduser("~/.ollama_service_port")

def main(server_address, port):
    print(f"Server address: {server_address}")
    print(f"Port: {port}")

    template = """Question: {question}

    Answer: Let's think step by step."""

    prompt = ChatPromptTemplate.from_template(template)
    model = OllamaLLM(model="llama3", base_url=f"http://{server_address}:{port}",)
    chain = prompt | model
    res = chain.invoke({"question": "What is LangChain?"})
    print(res)


if __name__ == "__main__":
    import argparse

    if os.path.exists(PORT_FILE):
        with open(PORT_FILE, "r") as f:
            port = int(f.read().strip())
    else:
        port = 0
   
    parser = argparse.ArgumentParser()
    parser.add_argument("--server_address", type=str, default="localhost")
    if port > 0:
        parser.add_argument("--port", type=int, default=port)
    else:
        parser.add_argument("--port", type=int, required=True)
    args = parser.parse_args()

    main(args.server_address, args.port)