# K8s 마이크로서비스 데모

이 프로젝트는 Kubernetes 환경에서 Redis, Kafka, MariaDB를 활용하는 간단한 마이크로서비스 데모입니다.

## 프로젝트 구조

- `frontend/`: Vue.js 기반 프론트엔드
- `backend/`: Flask 기반 백엔드
- `k8s/`: Kubernetes 설정 파일

## 기능

1. MariaDB
   - 메시지 저장 및 조회
   - 시간순 정렬 지원

2. Redis
   - 최신 메시지 저장 및 조회
   - 캐시로 활용

3. Kafka
   - 메시지 발행 및 구독
   - 비동기 메시지 처리

## 설치 및 실행

### 사전 요구사항

- Rancher Desktop
- Redis
- Kafka
- MariaDB

### 데이터베이스 설정

MariaDB에서 다음 테이블을 생성하세요:

```sql
CREATE DATABASE testdb;
USE testdb;

CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT,
    created_at DATETIME
);
```

### 백엔드 실행

```bash
cd backend
pip install -r requirements.txt
python app.py
```

### 프론트엔드 실행

```bash
cd frontend
npm install
npm run serve
```

## API 엔드포인트

### MariaDB
- POST /db/message: 메시지 저장
- GET /db/messages: 모든 메시지 조회

### Redis
- POST /redis/message: 메시지 저장
- GET /redis/message: 최신 메시지 조회

### Kafka
- POST /kafka/message: 메시지 발행
- GET /kafka/messages: 구독된 메시지 조회 