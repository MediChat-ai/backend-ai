# backend-ai

## 개요
비교적 저렴한 비용으로 GPU 서버를 deploy 할 수 있는 [runpod.io](https://runpod.io) 서비스를 활용하여 `.safetensors` (`.hf` 라고 부르기도 함) 형식의 AI 모델을 `.gguf` 형식의 모델로 변환하는 자동화 스크립트입니다.

## runpod 세팅
runpod 계정에 $10 이상 과금 후 아래의 과정을 진행합니다.

![runpod_1.png](https://firebasestorage.googleapis.com/v0/b/storage-f1f46.appspot.com/o/runpod_1.png?alt=media&token=31d1e4e0-5321-4cd1-be11-b1e774d99629)

충분한 storage 환경을 위해 추가 스토리지를 구매해야 합니다.  Create Network Volume > `EU-SE-1` 선택, 100GB를 할당합니다.

![runpod_2.png](https://firebasestorage.googleapis.com/v0/b/storage-f1f46.appspot.com/o/runpod_2.png?alt=media&token=ba016932-ccd1-4bc3-9f12-2687212d781d)

앞서 만든 network volume 선택,

![runpod_3.png](https://firebasestorage.googleapis.com/v0/b/storage-f1f46.appspot.com/o/runpod_3.png?alt=media&token=d0180789-776a-4f3f-a978-f5b7ef7c498b)

GPU는 NVIDIA A40 선택 후 deploy 합니다.

![runpod_4](https://firebasestorage.googleapis.com/v0/b/storage-f1f46.appspot.com/o/runpod_4.png?alt=media&token=3120d698-295a-4aa1-9a6d-23a97d168df4)

deploy 한 서버 화면의 Connect 버튼을 클릭하면 웹 터미널에 접근할 수 있습니다.

## 스크립트 실행

runpod 에서 서버를 deploy 한 최초 상태인 `root` 유저로 실행해야 합니다.

```sh
curl -sSL "https://raw.githubusercontent.com/MediChat-ai/backend-ai/refs/heads/main/hf-to-gguf.sh" | bash -s <model_name>
```
