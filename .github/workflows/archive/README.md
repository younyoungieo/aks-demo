# ACR 워크플로우 아카이브

이 폴더에는 Azure Container Registry (ACR)를 사용하는 기존 CI/CD 워크플로우들이 보관되어 있습니다.

## 📁 보관된 파일들

- `ci-pipeline.yml` - ACR에 이미지 빌드 및 푸시
- `deploy-to-aks.yml` - AKS에 애플리케이션 배포

## 🔄 언제 사용하나요?

- **Azure AKS 환경**에서 배포할 때
- **로컬 개발 완료 후** 프로덕션 배포 시
- **ACR 환경**으로 다시 전환할 때

## 📝 현재 사용 중인 워크플로우

- `docker-hub-ci.yml` - Docker Hub CI/CD 파이프라인 (현재 활성)

## 🚀 복원 방법

```bash
# ACR 워크플로우 복원
mv .github/workflows/archive/ci-pipeline.yml .github/workflows/
mv .github/workflows/archive/deploy-to-aks.yml .github/workflows/

# Docker Hub 워크플로우 아카이브로 이동
mv .github/workflows/docker-hub-ci.yml .github/workflows/archive/
```
