#!/bin/sh

#  make_adsService.sh
#  
#
#  Created by Bonsung Koo on 31/01/2025.
#  

FILE_PATH=$CI_PRIMARY_REPOSITORY_PATH/Surcharges/Shared/Services/Ads/ProductionAdsService/Sources/ProductionAdsService.swift

echo "import Foundation" >> $FILE_PATH
echo "import AdsServiceProtocol" >> $FILE_PATH
echo "public final class ProductionAdsService: AdsServiceProtocol {" >> $FILE_PATH
echo "public init() { }" >> $FILE_PATH
echo "public var isShowingAds: Bool {" >> $FILE_PATH
echo "get {" >> $FILE_PATH
echo "return UserDefaults.standard.bool(forKey: "isShowingAds")" >> $FILE_PATH
echo "}" >> $FILE_PATH
echo "set {" >> $FILE_PATH
echo "UserDefaults.standard.set(newValue, forKey: "isShowingAds")" >> $FILE_PATH
echo "}" >> $FILE_PATH
echo "}" >> $FILE_PATH
echo "public var fixedBannerUnitId = \"$AD_FIXED_BANNER_UNIT_ID\"" >> $FILE_PATH
echo "public var listBannerUnitId = \"$AD_LIST_BANNER_UNIT_ID\"" >> $FILE_PATH
echo "}" >> $FILE_PAT