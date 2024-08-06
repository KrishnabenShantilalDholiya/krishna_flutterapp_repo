from flask import Flask, request, jsonify
from transformers import AutoModelForCausalLM, AutoTokenizer

app = Flask(__name__)

model_name = "meta-llama/Meta-Llama-3.1-8B"
token = "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"  # Replace with your actual token

# Load the model and tokenizer
tokenizer = AutoTokenizer.from_pretrained(model_name, use_auth_token=token)
model = AutoModelForCausalLM.from_pretrained(model_name, use_auth_token=token)

@app.route('/generate', methods=['POST'])
def generate():
    data = request.json
    prompt = data['prompt']
    inputs = tokenizer(prompt, return_tensors="pt")
    outputs = model.generate(**inputs)
    text = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return jsonify({'response': text})

if __name__ == '__main__':
    app.run(debug=True)
