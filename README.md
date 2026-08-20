# [iOS] ADXLibrary Adapters — Swift Package Manager

ADX 미디에이션 라이브러리 및 광고 네트워크 어댑터를 Swift Package Manager(SPM)로 제공합니다.

- **지원 iOS**: iOS 13.0+
- **Swift Tools Version**: 5.7

---

## 제공 Product 목록

필요한 어댑터만 선택적으로 설치할 수 있습니다.

| Product | 광고 네트워크 | 설명 |
|---------|------------|------|
| `ADX-GoogleAds` | Google Mobile Ads | ADX : Google AdMob / Ad Manager 어댑터 |
| `ADX-AdPie` | AdPie | ADX : AdPie 어댑터 |
| `ADX-AppLovin` | AppLovin MAX | ADX: AppLovin 어댑터 |
| `ADX-Fyber` | Digital Turbine Exchange | ADX : Fyber 어댑터 |
| `ADX-Pangle` | Pangle (ByteDance) | ADX : Pangle 어댑터 |
| `ADX-UnityAds` | Unity Ads | ADX : Unity Ads 어댑터 |
| `GoogleMobileAds-Meta` | Meta Audience Network | Google Mobile Ads : Meta 어댑터 |

---

## 설치 방법

### Xcode (GUI)

1. Xcode 상단 메뉴 → **File > Add Package Dependencies...**
2. 검색창에 패키지 URL 입력:
   ```
   https://github.com/adxcorp/adx-ios-spm-adapters
   ```
3. **버전 규칙(Dependency Rule)** 선택 후 **Add Package** 클릭
4. **Choose Package Products** 화면에서 설치할 product 선택:

   ```
   ✅ ADX-AdPie          → 사용할 어댑터만 체크
   ☐ ADX-GoogleAds       
   ☐  ADX-AppLovin
   ☐  ADX-Fyber
   ☐  ADX-Pangle
   ☐  ADX-UnityAds
   ✅  GoogleMobileAds-Meta → 사용할 어댑터만 체크
   ```

5. **Add Package** 클릭

---

## 참고 사항

- 원하는 Product만 타겟에 추가하면 해당 어댑터만 컴파일·링크됩니다.
