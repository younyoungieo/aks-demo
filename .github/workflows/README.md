# GitHub Actions Workflows

이 프로젝트는 두 개의 GitHub Actions 워크플로우를 사용합니다:

## 1. CI Pipeline (`ci-pipeline.yml`)

**트리거**: `main` 브랜치에 push 또는 pull request가 생성될 때

**작업**:
- Backend Docker 이미지 빌드 및 ACR 푸시
- Frontend Docker 이미지 빌드 및 ACR 푸시

## 2. Deploy to AKS (`deploy-to-aks.yml`)

**트리거**: CI Pipeline이 성공적으로 완료된 후

**작업**:
- Azure AKS 클러스터에 애플리케이션 배포
- Kubernetes 매니페스트 적용

## 필요한 GitHub Secrets

다음 시크릿들을 GitHub 저장소 설정에서 추가해야 합니다:

### ACR (Azure Container Registry) 관련:
- `ACR_LOGIN_SERVER`: ACR 로그인 서버 (예: `yourregistry.azurecr.io`)
- `ACR_USERNAME`: ACR 사용자명
- `ACR_PASSWORD`: ACR 비밀번호

### Azure 및 AKS 관련:
- `AZURE_CREDENTIALS`: Azure 서비스 주체 인증 정보 (JSON)
- `AKS_RESOURCE_GROUP`: AKS 클러스터가 있는 리소스 그룹명
- `AKS_CLUSTER_NAME`: AKS 클러스터명

## 시크릿 설정 방법

1. GitHub 저장소 → Settings → Secrets and variables → Actions
2. "New repository secret" 클릭
3. 위의 각 시크릿들을 추가

## Azure 서비스 주체 생성

Azure CLI를 사용하여 서비스 주체를 생성할 수 있습니다:

```bash
az ad sp create-for-rbac --name "github-actions-aks" --role contributor \
  --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group} \
  --sdk-auth
```

생성된 JSON 출력을 `AZURE_CREDENTIALS` 시크릿에 저장하세요.
