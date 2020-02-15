module Linear.V3Spec (
  spec
) where

import           Test.Hspec
import           Test.QuickCheck

import           Linear.Epsilon
import           Linear.Metric
import           Linear.Vector

import           Linear.V3.Arbitrary

import           Debug.Trace
-- | test for the property `|v| = 1`
prop_UnitV3_isUnit :: UnitV3 Double -> Bool
prop_UnitV3_isUnit (UnitV3 v) = nearZero $ norm v - 1

-- | test for the property `|v*c| = c` for unit vector v and arbitrary scalar c
prop_Metric_V3_norm :: UnitV3 Double -> Double -> Bool
prop_Metric_V3_norm (UnitV3 v) c = nearZero $ norm (v ^* c) - (abs c)

-- | test for the property `signorm(v*c) = v` for unit vector v
prop_Metric_V3_signorm :: UnitV3 Double -> Double -> Bool
prop_Metric_V3_signorm (UnitV3 v) c = nearZero $ signorm (v ^* c) - v


spec :: Spec
spec = do
  describe "V3" $ do
    describe "Arbitrary" $ do
      describe "UnitV3" $ do
        it "satisfies the property `|v| = 1`" $ do
          property prop_UnitV3_isUnit
    describe "Metric" $ do
      it "satisfies property `|v*c| = c` for unit vectors" $
        property prop_Metric_V3_norm
      it "satisfies property `signorm(v*c) = v` for unit vectors" $
        property prop_Metric_V3_norm