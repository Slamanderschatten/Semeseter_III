using UnityEngine;
using UnityEngine.AI;

namespace avatar
{
    public class Knight : MonoBehaviour
    {
        
        private NavMeshAgent agent;
        
        void Awake() 
        {
            agent = GetComponent<NavMeshAgent>();
        }
        

        public void GotTo(Vector3 targetPosition)
        {
            agent.SetDestination(targetPosition);
        }
    }
}