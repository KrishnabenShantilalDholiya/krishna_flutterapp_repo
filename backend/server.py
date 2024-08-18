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
# ------------------------------------without fine-tuneing----------------
# from flask import Flask, request, jsonify
# from transformers import AutoModelForCausalLM, AutoTokenizer

# app = Flask(__name__)

# model_name = "facebook/opt-125m"
# token = "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"  # Replace with your actual token

# # Load the model and tokenizer with caching to reduce memory usage
# tokenizer = AutoTokenizer.from_pretrained(model_name, use_auth_token=token)
# model = AutoModelForCausalLM.from_pretrained(model_name, use_auth_token=token, torch_dtype="auto", low_cpu_mem_usage=True)

# @app.route('/generate', methods=['POST'])
# def generate():
#     if request.is_json:
#         data = request.json
#         prompt = data.get('prompt', '')

#         if not prompt:
#             return jsonify({'error': 'Prompt is required'}), 400

#         # Tokenize the input prompt
#         inputs = tokenizer(prompt, return_tensors="pt")

#         # Generate the output using the model with adjusted parameters
#         outputs = model.generate(
#             **inputs,
#             max_length=50,
#             num_return_sequences=1,
#             temperature=0.9,  # Increase temperature to reduce repetition
#             top_k=50,
#             top_p=0.9,
#             repetition_penalty=1.2  # Add repetition penalty
#         )

#         # Decode the generated tokens to text
#         text = tokenizer.decode(outputs[0], skip_special_tokens=True)

#         return jsonify({'response': text})
#     else:
#         return jsonify({'error': 'Unsupported Media Type, expecting application/json'}), 415

# if __name__ == '__main__':
#     app.run(debug=True)


# --------------------------------fine-tune model-------------
# from flask import Flask, request, jsonify
# from transformers import AutoModelForCausalLM, AutoTokenizer

# app = Flask(__name__)

# model_name = "facebook/opt-125m"
# token = "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"  # Replace with your actual token

# # Load the model and tokenizer with caching to reduce memory usage
# tokenizer = AutoTokenizer.from_pretrained(model_name, use_auth_token=token)
# model = AutoModelForCausalLM.from_pretrained(model_name, use_auth_token=token, torch_dtype="auto", low_cpu_mem_usage=True)

# @app.route('/generate', methods=['POST'])
# def generate():
#     if request.is_json:
#         data = request.json
#         prompt = data.get('prompt', '')

#         if not prompt:
#             return jsonify({'error': 'Prompt is required'}), 400

#         # Improve the input prompt
#         improved_prompt = f"Please solve the following problem: {prompt}"

#         # Tokenize the input prompt
#         inputs = tokenizer(improved_prompt, return_tensors="pt")

#         # Generate the output using the model with adjusted parameters
#         outputs = model.generate(
#             **inputs,
#             max_length=50,
#             num_return_sequences=1,
#             temperature=0.9,  # Increase temperature to make the model generate more diverse responses
#             top_k=50,
#             top_p=0.9,
#             repetition_penalty=1.2  # Add repetition penalty
#         )

#         # Decode the generated tokens to text
#         text = tokenizer.decode(outputs[0], skip_special_tokens=True)

#         return jsonify({'response': text})
#     else:
#         return jsonify({'error': 'Unsupported Media Type, expecting application/json'}), 415

# if __name__ == '__main__':
#     app.run(debug=True)


# =============================================new===============================

from flask import Flask, request, jsonify
from transformers import AutoModelForCausalLM, AutoTokenizer

app = Flask(__name__)

# Define the models and their names
models = {
    "facebook/opt-125m": {
        "tokenizer": None,
        "model": None
    },
    "bigscience/bloom-560m": {
        "tokenizer": None,
        "model": None
    }
}

token = "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"  # Replace with your actual token

# Load the models and tokenizers
for model_name in models:
    print(f"Loading model: {model_name}")
    models[model_name]["tokenizer"] = AutoTokenizer.from_pretrained(model_name, token=token)
    models[model_name]["model"] = AutoModelForCausalLM.from_pretrained(model_name, token=token, torch_dtype="auto", low_cpu_mem_usage=True)
    print(f"Loaded model: {model_name}")

@app.route('/generate', methods=['POST'])
def generate():
    if request.is_json:
        data = request.json
        prompt = data.get('prompt', '')
        model_name = data.get('model', '')

        if not prompt:
            return jsonify({'error': 'Prompt is required'}), 400

        if model_name not in models:
            return jsonify({'error': 'Invalid model name'}), 400

        # Improve the input prompt
        improved_prompt = f"Please solve the following problem: {prompt}"
        print(f"Improved prompt: {improved_prompt}")

        # Tokenize the input prompt
        tokenizer = models[model_name]["tokenizer"]
        model = models[model_name]["model"]
        inputs = tokenizer(improved_prompt, return_tensors="pt")

        # Generate the output using the model with adjusted parameters
        outputs = model.generate(
            **inputs,
            max_length=50,
            num_return_sequences=1,
            temperature=0.9,  # Increase temperature to make the model generate more diverse responses
            top_k=50,
            top_p=0.9,
            repetition_penalty=1.2  # Add repetition penalty
        )

        # Decode the generated tokens to text
        text = tokenizer.decode(outputs[0], skip_special_tokens=True)

        return jsonify({'response': text, 'model': model_name})
    else:
        return jsonify({'error': 'Unsupported Media Type, expecting application/json'}), 415

if __name__ == '__main__':
    app.run(debug=True)
