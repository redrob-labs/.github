# Redrob Labs

이 조직의 모든 저장소에 적용되는 community health 기본값입니다.

English: [README.md](./README.md)

## 여기 있는 것

| 파일 | 정하는 것 |
|---|---|
| [CONTRIBUTING.ko.md](./CONTRIBUTING.ko.md) | 외부 기여자가 변경을 머지시키는 방법. |
| [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md) | 서로를 대하는 방식. |
| [SECURITY.md](./SECURITY.md) | 취약점 신고를 보내는 곳. 공개 이슈는 절대 아닙니다. |
| [SUPPORT.md](./SUPPORT.md) | 질문을 보내는 곳. |
| [FORKS.ko.md](./FORKS.ko.md) | 이 저장소 상당수가 포크이기 때문에 적용되는 규칙. |

이 경로의 파일은 **이 조직에서 자기 사본이 없는 모든 저장소**에 쓰입니다. 저장소 자신의 파일이 항상
이기므로 덮어쓰기가 아니라 바닥값입니다. `profile/README.md` 는 조직 공개 프로필 페이지에
렌더링됩니다.

## 엔지니어링 표준은 다른 조직에 있습니다

브랜치, 저장소 명명, 디자인 토큰, AI 에이전트가 지켜야 할 규칙은 우리의 다른 조직과 공유되며, 여기에
복사하지 않고 그곳에 발행됩니다.

| | |
|---|---|
| [GITFLOW.ko.md](https://github.com/mckinley-and-rice/.github/blob/main/docs/GITFLOW.ko.md) | 브랜치, 머지, 릴리스, 핫픽스, 상류 싱크, CI가 강제하는 것. |
| [REPO-NAMING.ko.md](https://github.com/mckinley-and-rice/.github/blob/main/docs/REPO-NAMING.ko.md) | 저장소 이름, 설명, 토픽. |
| [DESIGN.ko.md](https://github.com/mckinley-and-rice/.github/blob/main/docs/DESIGN.ko.md) | 토큰, 타이포, 모션, 시각 변경 검증 방법. |
| [AGENTS.md](https://github.com/mckinley-and-rice/.github/blob/main/AGENTS.md) | AI 에이전트가 주장하기 전에 검증해야 할 것. |

복사하지 않고 링크하는 것은 의도입니다. 사본은 갈라지고, 갈라진 것을 아무도 보고하지 않습니다. 두
조직 모두 우리 것이고, 그 문서들은 둘 다에 적용되도록 쓰여 있습니다.

**GitHub의 health file 상속은 조직 경계에서 멈춥니다.** 다른 조직에 같은 네 문서가 이미 있는데도 이
저장소가 존재하는 이유가 그것입니다. 상속은 조직별이고, 표준은 그렇지 않습니다.

## 표준과 이 조직 사이의 격차

기록되지 않은 격차는 표준이 틀린 것으로 읽히므로 적어 둡니다.

[GITFLOW.ko.md](https://github.com/mckinley-and-rice/.github/blob/main/docs/GITFLOW.ko.md) 는
`develop` 을 기본 브랜치로 삼습니다. 여기 저장소 네 개가 아직 `main` 입니다. `redrob-image`,
`redrob-labs`, 그리고 보관된 `redrob-studio`, `redrob-verify`. 열두 개는 `develop` 입니다. 기본
브랜치를 바꾸는 것은 CI에 대한 브레이킹 체인지입니다. `branches: [main]` 로 필터된 워크플로가 조용히
돌기를 멈추기 때문입니다. 그래서 그 네 개는 각각 같은 변경 안에서 워크플로 브랜치 필터를 전수
점검해야 합니다.

## 이 저장소 자신의 브랜치

| | |
|---|---|
| `main` | **기본이자 유일한 브랜치.** GitHub가 상속되는 health 파일을 여기서 제공합니다. |
| 브랜치 이름 | `<type>/<slug>`, 타입은 `feat fix chore docs test refactor perf`. |

변경은 `main` 을 향한 풀 리퀘스트로 바로 들어옵니다. `develop` 은 없습니다. `.github` 저장소의
기본 브랜치는 다른 모든 저장소에 제공되는 면이고, 이 저장소는 문서와 공용 워크플로만 담아 스스로
빌드할 것이 없기 때문입니다. `main` 은 보호되고 관리자에게도 적용됩니다.
