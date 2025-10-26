using System;
using Truck;
using UnityEngine;
using UnityEngine.InputSystem;

namespace flora
{
    public class FloraItem : MonoBehaviour
    {

        public float interactionDistance;
        private void OnMouseDown()
        {
            TruckControl truck = FindAnyObjectByType<TruckControl>().GetComponent<TruckControl>();
            if(Vector3.Distance(truck.transform.position, transform.position) <= interactionDistance)
            {
                if (truck.AddTrunk())
                    Destroy(gameObject);
            }
        }
    }
}