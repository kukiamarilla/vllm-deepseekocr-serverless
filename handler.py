from vllm import LLM, SamplingParams

# Se inicializa solo una vez por contenedor
llm = LLM(model="deepseek-ai/deepseek-ocr")

def handler(event):
    """RunPod Serverless entrypoint"""
    input_data = event.get("input", {})
    prompt = input_data.get("prompt", "")
    temperature = float(input_data.get("temperature", 0.1))
    max_tokens = int(input_data.get("max_tokens", 256))

    sampling_params = SamplingParams(
        temperature=temperature,
        max_tokens=max_tokens
    )

    outputs = llm.generate([prompt], sampling_params=sampling_params)
    text = outputs[0].outputs[0].text

    return {"output": text}