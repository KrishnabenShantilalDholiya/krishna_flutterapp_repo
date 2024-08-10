# from flask import Flask, request, jsonify
# from transformers import AutoModelForCausalLM, AutoTokenizer

# app = Flask(__name__)

# model_name = "meta-llama/Meta-Llama-3.1-8B"
# token = "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"  # Replace with your actual token

# # Load the model and tokenizer
# tokenizer = AutoTokenizer.from_pretrained(model_name, use_auth_token=token)
# model = AutoModelForCausalLM.from_pretrained(model_name, use_auth_token=token)

# @app.route('/generate', methods=['POST'])
# def generate():
#     data = request.json
#     prompt = data['prompt']
#     inputs = tokenizer(prompt, return_tensors="pt")
#     outputs = model.generate(**inputs)
#     text = tokenizer.decode(outputs[0], skip_special_tokens=True)
#     return jsonify({'response': text})

# if __name__ == '__main__':
#     app.run(debug=True)


from flask import Flask, request, jsonify
from transformers import AutoModelForCausalLM, AutoTokenizer

app = Flask(__name__)

model_name = "meta-llama/Meta-Llama-3.1-8B"
token = "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" #Replace with your actual token

# Load the model and tokenizer with caching to reduce memory usage
tokenizer = AutoTokenizer.from_pretrained(model_name, token=token)
model = AutoModelForCausalLM.from_pretrained(model_name, token=token, torch_dtype="auto", low_cpu_mem_usage=True)

@app.route('/generate', methods=['POST'])
def generate():
    if request.is_json:
        data = request.json
        prompt = data.get('prompt', '')
        
        # Tokenize the input prompt
        inputs = tokenizer(prompt, return_tensors="pt")
        
        # Generate the output using the model
        
        outputs = model.generate(**inputs, max_length=50, num_return_sequences=1, temperature=0.7, top_k=50, top_p=0.9)
        
        # Decode the generated tokens to text
        text = tokenizer.decode(outputs[0], skip_special_tokens=True)
        
        return jsonify({'response': text})
    else:
        return jsonify({'error': 'Unsupported Media Type, expecting application/json'}), 

if __name__ == '__main__':
    app.run(debug=True)
    