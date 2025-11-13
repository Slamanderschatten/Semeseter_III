using System;
using avatar;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.InputSystem;

namespace InteractionObjects
{
    public class Destroyable : MonoBehaviour
    {
        public GameObject destroyedObjectPrefab;
        public Knight avatar;


        private void Start()
        {
            avatar = FindObjectsByType<Knight>(FindObjectsSortMode.None)[0];
        }


        void OnMouseDown()
        {
            //condition
            Vector3 direction = transform.position - avatar.transform.position;
            if(direction.magnitude < 3.0f)
            {
                if (Vector3.Angle(avatar.transform.forward, direction) < 80)
                {

                    //destroyed object
                    GameObject destroyedObj = Instantiate(destroyedObjectPrefab);
                    destroyedObj.transform.position = transform.position;
                    destroyedObj.transform.rotation = transform.rotation;
                    destroyedObj.transform.localScale = transform.localScale;
                    if (transform.parent)
                        destroyedObj.transform.SetParent(transform.parent);

                    Destroy(gameObject);
                }
                else
                {
                    avatar.transform.rotation = Quaternion.LookRotation(direction);
                }
            }
        }
    }
}