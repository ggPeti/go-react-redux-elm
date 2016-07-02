module Components.Board exposing (board)

import Html as H
import Html.Attributes as A

import Components.Intersection exposing (intersection)
import Constants as C
import Model


board : Model.Board -> H.Html message
board boardState =
  let size = 100 / toFloat (List.length boardState) in
    H.div [A.class "row"] [
      H.div [
        A.class "card col s12 m8 push-m2 l6 push-l3",
        A.style [("background", "#DCB771"), ("padding", "12px")]
      ]
      (List.indexedMap
        (\i row ->
          H.div
            [
              A.class "clearfix",
              A.style [("height", toString size ++ "%"), ("position", "relative")]
            ]
            (List.indexedMap
              (\j intersectionState ->
                intersection {
                  col = j,
                  isBottomEdge = i == C.grid_size - 1,
                  isLeftEdge = j == 0,
                  isRightEdge = j == C.grid_size - 1,
                  isStarPoint =
                    (i == 3 || i == C.grid_size - 4 || i == (C.grid_size - 1) // 2)
                      && (j == 3 || j == C.grid_size - 4 || j == (C.grid_size - 1) // 2),
                  isTopEdge = i == 0,
                  row = i,
                  state = intersectionState,
                  width = size
                })
              row))
      boardState)
    ]
