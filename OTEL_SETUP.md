# OpenTelemetry 자동계측 설정 가이드

## 개요
이 프로젝트는 Azure AKS 144 클러스터의 `lgtm` 네임스페이스에 있는 기존 Tempo, Grafana, Loki, Mimir 인프라를 활용하여 백엔드 애플리케이션의 자동계측을 구현합니다.

## 기존 인프라 구성 (lgtm 네임스페이스)
- **Tempo**: 트레이스 수집 및 저장 (OpenTelemetry Collector 역할)
  - `tempo-distributor.lgtm:4318` - OTLP HTTP 수신
  - `tempo-distributor.lgtm:4317` - OTLP gRPC 수신
- **Grafana**: 대시보드 및 시각화
- **Loki**: 로그 수집
- **Mimir**: 메트릭 수집

## 설정된 자동계측
- **Flask**: HTTP 요청/응답 자동 추적
- **MySQL**: 데이터베이스 쿼리 자동 추적  
- **Redis**: Redis 작업 자동 추적
- **Kafka**: Kafka 메시지 전송/수신 자동 추적

## 배포 방법

### 1. 백엔드 이미지 빌드 및 푸시
```bash
cd backend
docker build -t ktech4.azurecr.io/younyoung-aks-demo-backend:latest .
docker push ktech4.azurecr.io/younyoung-aks-demo-backend:latest
```

### 2. Kubernetes 배포
```bash
kubectl apply -f k8s/backend-deployment.yaml
```

### 3. 서비스 상태 확인
```bash
kubectl get pods -n younyoung -l app=backend
kubectl logs -n younyoung -l app=backend
```

## 환경변수
- `OTEL_EXPORTER_OTLP_ENDPOINT`: `http://tempo-distributor.lgtm:4318/v1/traces`
- `OTEL_SERVICE_NAME`: 서비스 이름 (Grafana에서 표시됨)
- `OTEL_RESOURCE_ATTRIBUTES`: 서비스 메타데이터

## 확인 방법
1. `lgtm` 네임스페이스의 Grafana에 접속하여 `backend-service` 서비스를 찾습니다
2. Traces 탭에서 HTTP 요청, DB 쿼리, Redis 작업 등의 추적 데이터를 확인할 수 있습니다
3. 서비스 맵에서 백엔드 서비스와 다른 서비스들 간의 의존성을 시각적으로 확인할 수 있습니다

## 접속 방법
```bash
# Grafana 접속 (포트 포워딩)
kubectl port-forward -n lgtm svc/grafana 3000:80

# Grafana 접속 정보
# URL: http://localhost:3000
# 기본 계정: admin/admin (또는 설정된 계정)
```

## 주의사항
- `lgtm` 네임스페이스의 `tempo-distributor` 서비스가 OTLP HTTP 프로토콜을 지원합니다 (포트 4318)
- 네트워크 정책이 `younyoung` 네임스페이스에서 `lgtm` 네임스페이스로의 통신을 허용해야 합니다
- Tempo가 트레이스 데이터를 수집하고 Grafana에서 시각화할 수 있습니다
