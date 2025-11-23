using System;
using System.Collections.Generic;
using avatar;
using UnityEngine;
using UnityEngine.InputSystem;
using Random = UnityEngine.Random;

namespace ground
{
    public class ClickGround : MonoBehaviour
    {

        public Knight avatar;


        void OnMouseDown() {
            Vector3 targetPos = GetMouseHit(LayerMask.GetMask("Ground"));
            avatar.GotTo(targetPos);
        }


        private void OnMouseDrag()
        {
            throw new NotImplementedException();
        }


        private Vector3 GetMouseHit(LayerMask layerMask)
        {
            Vector2 mousePos = Mouse.current.position.ReadValue();

            Ray ray = Camera.main.ScreenPointToRay(mousePos);

            if (Physics.Raycast(ray, out RaycastHit hit, Mathf.Infinity, layerMask))
            {
                return hit.point;
            }
            return Vector3.negativeInfinity;
        }
        
        
        
        
    }
}