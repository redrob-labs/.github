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
| [FORKS.ko.md](./FORKS.ko.md) | 이 저장소 대부분이 포크이기 때문에 적용되는 규칙. |

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
`develop` 을 기본 브랜치로 삼습니다. 여기 저장소 네 개가 아직 `main` 입니다. `redrob-studio`,
`redrob-verify`, `redrob-image`, `redrob-labs`. 열네 개는 `develop` 입니다. 기본
브랜치를 바꾸는 것은 CI에 대한 브레이킹 체인지입니다. `branches: [main]` 로 필터된 워크플로가 조용히
돌기를 멈추기 때문입니다. 그래서 그 네 개는 각각 같은 변경 안에서 워크플로 브랜치 필터를 전수
점검해야 합니다.

공개 저장소 세 개가 GitHub가 분류할 수 없는 라이선스를 출하하고 있어 사이드바에 라이선스가 아예
보이지 않습니다. `redrob-cowork`, `redrob-design`, `redrob-ide` 가 `NOASSERTION` 으로 나옵니다. 앞의
둘은 `LICENSE` 파일이 라이선스 본문보다 앞에 포크 저작권 줄을 쌓아 두었기 때문입니다. 라이선스는
실재하고 표기도 맞습니다. 깨진 것은 GitHub의 탐지뿐이며, 오픈소스 저장소에서는 대부분의 사람이 그
탐지로 확인합니다.

## 이 저장소 자신의 브랜치

| | |
|---|---|
| `main` | **기본.** 발행된 상태. GitHub가 상속되는 health file을 여기서 읽습니다. |
| `develop` | 통합. 변경이 먼저 여기로 들어오고, merge 커밋으로 승격됩니다. |
| 브랜치 이름 | `<type>/<slug>`, 타입은 `feat fix chore docs test refactor perf`. |

`main` 이 기본인 것은 공유 표준에서 의도적으로 벗어난 것이며, 그 근거는 표준 자신이 제시합니다.
`.github` 저장소의 기본 브랜치는 기여자의 시야가 아니라 다른 모든 저장소에 제공되는 표면입니다.
두 브랜치 모두 보호되며 admin 강제가 켜져 있습니다.
