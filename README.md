# 올바르미 All Bareumi

Group Project - Team RTA(너구리)

| **Name**          | **Student ID** | **Email**              | **Part**  |
| :---------------- | :------------- | :--------------------- | :---------|
| Taegyu Im         | 20185999       | bigstar9906@naver.com  | Backend   |
| Hayun Lee         | 20193418       | hayun0406@cau.ac.kr    | AI        | 
| Minki Kang        | 20201980       | bbx8216@gmail.com      | Frontend  |

---
## Contents
- [올바르미 All Bareumi](#올바르미-all-bareumi)
  - [Contents](#contents)
  - [Introduction](#introduction)
    - [Project Topic](#project-topic)
    - [Proposal Background](#proposal-background)
    - [Project Goal & Contribution](#project-goal--contribution)
  - [Representative Screenshots](#representative-screenshots)
  - [Implementation Details](#implementation-details)
    - [Service Architecture](#service-architecture)
    - [Technology Used](#technology-used) 
    - [Code](#code)
- [In Korean](#in-korean)

## Introduction
### Project Topic
Pronunciation correction learning application for children aged 5 to 7
### Proposal Background
- McGurk effect, the interaction between visual and auditory information
- The importance of speech therapists’ use of visual materials
- Problem with lack of visual(mouth) information due to COVID-19
- The importance of repetitive learning and interest elements in pronunciation training
- World Health Organization (WHO) announces ‘Disease X’
### Project Goal & Contribution
- Artificial intelligence technology creates audio-visual materials appropriate for learning and helps children who have difficulty with correct pronunciation to repeatedly practice pronunciation.
- To ensure children's continuous learning, we apply elements that can stimulate interest, such as setting rewards and giving stars based on scores, to help children ultimately complete training.
- Creation of a lip sync model specialized for Korean based on the lip sync model (Wav2Lip) implemented for existing foreign languages.

## Representative Screenshots

| <img src="https://github.com/All-Bareumi/.github/assets/81232059/856105b6-fe17-407e-b4be-89c0af0c6ec9" width="200px"/> | <img src="https://github.com/All-Bareumi/.github/assets/81232059/a49c9426-4905-4162-acf5-97099b3cb97d"  width="200px"/> | <img src="https://github.com/All-Bareumi/.github/assets/81232059/c437b47b-307f-412e-a77a-471aefe6fbe2"  width="200px"/> | <img src="https://github.com/All-Bareumi/.github/assets/81232059/8035d34c-40d9-45b8-80b0-68fe2566318a"  width="200px"/> |
| :--------------------------------------------------------------------- | :--------------------------------------------------------------------- | :-------------------------------------------------------------------------- | :-------------------------------------------------------------------------- |
| <img src="https://github.com/All-Bareumi/.github/assets/81232059/888ce4c2-3e37-496d-a23c-dbcee730fb5d" width="200px"/> | <img src="https://github.com/All-Bareumi/.github/assets/81232059/c6dff415-ed0f-4e76-837e-c63fdc07c75a"  width="200px"/> | <img src="https://github.com/All-Bareumi/.github/assets/81232059/8ca9347e-0382-4b74-a5c0-3f139ce49463"  width="200px"/> | <img src="https://github.com/All-Bareumi/.github/assets/81232059/9d77860a-18ec-414e-91c9-199cb5a3b65e"  width="200px"/> |
| <img src="https://github.com/All-Bareumi/.github/assets/81232059/680b4f42-0bc2-42ac-88fc-acc1c015742f" width="200px"/> | <img src="https://github.com/All-Bareumi/.github/assets/81232059/1aa7103c-35db-45da-a6d3-e1f9849a37cb"  width="200px"/> | <img src="https://github.com/All-Bareumi/.github/assets/81232059/9025f2e4-7f85-41e9-bd15-4cc9fd80f2bb"  width="200px"/> | <img src="https://github.com/All-Bareumi/.github/assets/81232059/a7d8ce2b-1f51-43ff-9806-996c74f008d9"  width="200px"/> |

## Implementation Details
### Service Architecture
<img width="450" alt="image" src="https://github.com/All-Bareumi/.github/assets/81232059/04873665-5f6e-409a-8a26-74f82dd6e756">

### Techonolgy Used
- Lip-Sync: Wav2Lip
- TTS & STT: Google API
- OCR & ETRI(Electronics and Telecommunications Research Institute) Pronunciation Evaluation API
- Node.js & Flask Server
- MongoDB
- Flutter

### Code
- [AI](https://github.com/All-Bareumi/All-Bareumi_AI)
- [BE](https://github.com/All-Bareumi/All-Bareumi_BE)
- [FE](https://github.com/All-Bareumi/All-Bareumi_FE)

---

## In Korean

### 1. 프로젝트 주제
5~7세 어린이 대상 발음 교정 학습 어플리케이션

### 2. 제안배경
- 시각 정보와 청각 정보의 상호작용인 맥거크 효과
- 언어치료사의 시각자료 활용 중요성
- 코로나19로 인한 시각 정보 부족 문제
- 발음 훈련의 반복학습과 흥미 요소 중요성
- 세계 보건 기구(WHO)의 '질병 X' 발표

### 4. 프로젝트 소개
**주요 기능**
- 문장 발음 학습 및 입모양 제시
- 카테고리별 회화 위주 문장 제공
- 학습자료의 입모양과 실제 입모양 비교 확인
- 학습자 커스텀을 위한 OCR과 TTS 활용
- 입모양 아바타 선택
- Wav2Lip를 활용한 입모양 아바타 생성
- 학습자 발음 분석 및 레벨 설정
- 보상 시스템을 통한 흥미 유발
- 전래동화 들려주기와 입모양 제시

### 5. 목표(기여)
- 인공지능을 활용한 학습에 적합한 시청각 자료 생성
- 발음 교정이 필요한 어린이들의 발음 훈련 보조
- 흥미 유발을 통한 꾸준한 학습 도모

### 6. 차별성
- 다양한 학습 자료 제공 및 입모양 제시
- 유사 서비스와의 비교를 통한 차별화

### 7. 개발 및 구현
**주요 기술**
- Lip-Sync: Wav2Lip
- TTS & STT: Google API 활용 예정
- OCR 및 발음 분석 기술 활용
- Node.js 및 Flask 서버로 클라이언트와 연결
- MongoDB 데이터베이스 활용
