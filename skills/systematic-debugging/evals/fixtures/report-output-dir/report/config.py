import os


def load_config(env=None):
    env = os.environ if env is None else env
    return {
        "output_dir": env.get("REPORT_OUT_DIR", ""),
        "title": env.get("REPORT_TITLE", "Daily Report"),
    }
