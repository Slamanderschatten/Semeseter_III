using System;
using UnityEngine;

namespace stoneCrush
{
    public class Destroyer : MonoBehaviour
    {
        private void Awake()
        {
            Destroy(gameObject);
        }
    }
}