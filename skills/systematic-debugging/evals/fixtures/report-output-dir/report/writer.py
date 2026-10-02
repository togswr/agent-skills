import os


def write_report(config, name, body):
    path = os.path.join(config["output_dir"], name)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        f.write(f"# {config['title']}\n\n{body}\n")
    return path
