from huggingface_hub import snapshot_download
import sys
snapshot_download(repo_id=f'{sys.argv[1]}')
